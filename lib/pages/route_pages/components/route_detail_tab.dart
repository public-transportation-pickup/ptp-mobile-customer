import 'package:capstone_ptp/models/route_model.dart';
import 'package:flutter/material.dart';

import 'sub_components/route_info_tab.dart';
import 'sub_components/route_schedule_tab.dart';
import 'sub_components/route_trips_tab.dart';

class RouteDetailTab extends StatefulWidget {
  final RouteModel routeDetail;
  final String currentRouteVar;

  final Key key;

  RouteDetailTab({
    required this.routeDetail,
    required this.currentRouteVar,
    required this.key,
  }) : super(key: key);

  @override
  _RouteDetailTabState createState() => _RouteDetailTabState();
}

class _RouteDetailTabState extends State<RouteDetailTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //late Future<List<RouteVarModel>> _routeVars;
  late String routeVarId;
  //late Future<List<TripModel>> _trips;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    routeVarId = widget.currentRouteVar;
    //_routeVars = RouteApi.getRouteVarsByRouteId(widget.routeDetail.id);
    //_trips = RouteApi.getTrips(widget.routeDetail.id, 'yourRouteVarId');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Biểu đồ giờ'),
            Tab(text: 'Lộ trình'),
            Tab(text: 'Thông tin'),
          ],
          unselectedLabelColor: const Color(0xFF919191),
          labelColor: const Color(0xFFFBAB40),
          labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat'),
          unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat'),
          indicatorColor: const Color(0xFFFBAB40),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Tab 1: Timetable
              SingleChildScrollView(
                child: RouteScheduleTab(
                    routeId: widget.routeDetail.id, routeVarId: routeVarId),
              ),
              // Tab 2: Trips
              SingleChildScrollView(
                child: RouteTripsTab(
                    routeId: widget.routeDetail.id, routeVarId: routeVarId),
              ),
              // Tab 3: Info
              SingleChildScrollView(
                child: RouteInfoTab(routeDetail: widget.routeDetail),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
