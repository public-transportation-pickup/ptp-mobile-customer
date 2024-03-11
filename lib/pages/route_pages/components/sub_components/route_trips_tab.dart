import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/route_var_model.dart';
import 'package:capstone_ptp/models/trip_model.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';

class RouteTripsTab extends StatefulWidget {
  final String routeId;
  final String routeVarId;

  RouteTripsTab({required this.routeId, required this.routeVarId});

  @override
  _RouteTripsTabState createState() => _RouteTripsTabState();
}

class _RouteTripsTabState extends State<RouteTripsTab> {
  late Future<List<TripModel>> _tripsTurnGo = Future.value([]);
  late Future<List<TripModel>> _tripsTurnBack = Future.value([]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTripList(AsyncSnapshot<List<TripModel>> snapshot, String title) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error loading $title'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No $title available'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              TripModel trip = snapshot.data![index];
              return ListTile(
                title: Text('Trip ${index + 1}'),
                // Add more details or customize the ListTile as needed
              );
            },
          ),
        ],
      );
    }
  }
}
