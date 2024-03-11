import 'package:capstone_ptp/pages/route_pages/route_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  int tappedTripIndex = -1;
  String nextTripId = '';

  @override
  void initState() {
    super.initState();
    _trips = RouteApi.getTrips(widget.routeId, widget.routeVarId);
    setNextTripId(_trips);
  }

  void setNextTripId(Future<List<TripModel>> tripsFuture) {
    tripsFuture.then((List<TripModel> trips) {
      // Sort the trips based on start times
      trips.sort((a, b) => a.startTime.compareTo(b.startTime));

      DateTime test = DateTime(1970, 1, 1, 8, 0);

      for (TripModel trip in trips) {
        DateTime tripTime = DateFormat('HH:mm').parse(trip.startTime);

        if (tripTime.isAfter(test)) {
          nextTripId = trip.id;
          break;
        }
      }
      // Set the currentTripId to the nextTripId
      RouteDetailPage.currentTripId = nextTripId;
      print("Default trirp id: " + RouteDetailPage.currentTripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now(); // Get the current time
    DateTime test = DateTime(1970, 1, 1, 8, 0);
    bool isNextTrip = true;

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
                  children: rowTrips.asMap().entries.map((entry) {
                    int tripIndex = entry.key + startIndex;
                    TripModel trip = entry.value;

                    DateTime tripTime =
                        DateFormat('HH:mm').parse(trip.startTime);

                    Color textColor = Colors.black;
                    FontWeight textFontWeight = FontWeight.w400;

                    // Compare startTime with the current time
                    if (tripTime.isBefore(test) ||
                        tripTime.isAtSameMomentAs(test)) {
                      textColor = Colors.grey;
                    } else if (tripTime.isAfter(test)) {
                      if (tripIndex == tappedTripIndex) {
                        textColor = Colors.blue;
                        textFontWeight = FontWeight.bold;
                      } else if (isNextTrip) {
                        textColor = const Color(0xFFFCCF59);
                        textFontWeight = FontWeight.bold;
                        isNextTrip = false;
                      } else {
                        textColor = Colors.black;
                      }
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tappedTripIndex = tripIndex;
                                  RouteDetailPage.currentTripId =
                                      trips[tripIndex].id;
                                  print("Trip id: " +
                                      RouteDetailPage.currentTripId);
                                });
                              },
                              child: Text(
                                trip.startTime,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: textFontWeight,
                                  color: textColor,
                                ),
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
