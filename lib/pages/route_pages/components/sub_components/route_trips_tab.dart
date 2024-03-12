import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/trip_model.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';

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

  @override
  Widget build(BuildContext context) {
    if (RouteTripsTab.currentTripId.isEmpty) {
      // Return a message indicating no trips data
      return const Center(child: Text('Không có chuyến trong ngày.'));
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

          return SizedBox(
            height: MediaQuery.of(context).size.height,
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
                            "Thời gian đến: ${arrivalTime[index]}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFFCCF59)),
                            ),
                            onPressed: () {
                              // Navigate to another page here
                              // You can replace 'YourPage()' with the actual page you want to navigate to
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => YourPage()),
                              // );
                            },
                            child: const Text(
                              "Đặt đơn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
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
