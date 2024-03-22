import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/trip_model.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';
import 'package:intl/intl.dart';

import '../../../store_pages/store_detail_page.dart';

class RouteTripsTab extends StatefulWidget {
  static String currentTripId = '';
  RouteTripsTab();

  @override
  _RouteTripsTabState createState() => _RouteTripsTabState();
}

class _RouteTripsTabState extends State<RouteTripsTab> {
  Future<TripModel>? _trip;

  @override
  void initState() {
    super.initState();
    print("Current trip id: " + RouteTripsTab.currentTripId);
    if (RouteTripsTab.currentTripId.isNotEmpty) {
      _trip = fetchTripsAndProcess();
    }
  }

  Future<TripModel> fetchTripsAndProcess() async {
    try {
      // Replace the parameters with actual values
      return await RouteApi.getTripById(RouteTripsTab.currentTripId);
    } catch (e) {
      // Handle errors
      print("Error fetching and processing trips: $e");
      rethrow;
    }
  }

  String _formatTime(String time) {
    DateTime now = DateTime.now();
    DateTime formatedTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateFormat('HH:mm').parse(time).hour,
        DateFormat('HH:mm').parse(time).minute);
    return DateFormat('HH:mm').format(formatedTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    if (RouteTripsTab.currentTripId.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Text('Không có chuyến trong ngày.'),
      ));
    }

    return FutureBuilder<TripModel>(
      future: _trip,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          TripModel trip = snapshot.data!;
          List<String> stationNames = trip.schedules
                  ?.map((schedule) => schedule.stationName)
                  .toList() ??
              [];
          List<String> arrivalTime = trip.schedules
                  ?.map((schedule) => schedule.arrivalTime)
                  .toList() ??
              [];
          List<String?> stores =
              trip.schedules?.map((schedule) => schedule.storeId).toList() ??
                  [];
          List<String?> stationIds =
              trip.schedules?.map((schedule) => schedule.stationId).toList() ??
                  [];

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: stationNames.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  leading: const Icon(
                    size: 16,
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  title: Text(
                    stationNames[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thời gian đến: ${_formatTime(arrivalTime[index])}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (stores[index] == null || stores[index]!.isEmpty)
                            const Text(
                              "*Chưa có cửa hàng",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (stores[index] != null &&
                              stores[index]!.isNotEmpty)
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFFCCF59)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreDetailPage(
                                            storeId: stores[index]!,
                                            arrivalTime:
                                                _formatTime(arrivalTime[index]),
                                            stationId: stationIds[index]!,
                                          )),
                                );
                              },
                              child: const Text(
                                "Đặt đơn",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
