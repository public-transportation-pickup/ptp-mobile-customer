import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/trip_model.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';

class RouteTripsTab extends StatefulWidget {
  final String currentTripId;

  RouteTripsTab({required this.currentTripId});

  @override
  _RouteTripsTabState createState() => _RouteTripsTabState();
}

class _RouteTripsTabState extends State<RouteTripsTab> {
  Future<TripModel>? _trip;

  @override
  void initState() {
    super.initState();
    _trip = fetchTripsAndProcess();
  }

  Future<TripModel> fetchTripsAndProcess() async {
    try {
      // Replace the parameters with actual values
      return await RouteApi.getTripById(widget.currentTripId);
    } catch (e) {
      // Handle errors
      print("Error fetching and processing trips: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
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

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: stationNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
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
                );
              },
            ),
          );
        }
      },
    );
  }
}
