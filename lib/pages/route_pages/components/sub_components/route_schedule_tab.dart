import 'package:flutter/material.dart';

import '../../../../models/trip_model.dart';
import '../../../../services/api_services/route_api.dart';

class RouteScheduleTab extends StatefulWidget {
  final String routeId;
  final String routeVarId;

  RouteScheduleTab({required this.routeId, required this.routeVarId});

  @override
  _RouteScheduleTabState createState() => _RouteScheduleTabState();
}

class _RouteScheduleTabState extends State<RouteScheduleTab> {
  late Future<List<TripModel>> _trips;

  @override
  void initState() {
    super.initState();
    _trips = RouteApi.getTrips(widget.routeId, widget.routeVarId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TripModel>>(
      future: _trips,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có chuyến trong ngày.'));
        } else {
          // Sort the trips based on start times
          List<TripModel> trips = snapshot.data!;
          trips.sort((a, b) => a.startTime.compareTo(b.startTime));

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: (trips.length / 5).ceil(),
              itemBuilder: (context, rowIndex) {
                int startIndex = rowIndex * 5;
                int endIndex = (rowIndex + 1) * 5;
                endIndex = endIndex > trips.length ? trips.length : endIndex;

                List<TripModel> rowTrips = trips.sublist(startIndex, endIndex);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: rowTrips.map((trip) {
                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Text(
                              trip.startTime,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
