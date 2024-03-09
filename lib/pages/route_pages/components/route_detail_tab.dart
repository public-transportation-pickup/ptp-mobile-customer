import 'package:capstone_ptp/models/route_model.dart';
import 'package:flutter/material.dart';

import 'sub_components/route_info_tab.dart';

class RouteDetailTab extends StatefulWidget {
  final RouteModel routeDetail;

  RouteDetailTab({required this.routeDetail});

  @override
  _RouteDetailTabState createState() => _RouteDetailTabState();
}

class _RouteDetailTabState extends State<RouteDetailTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              const SingleChildScrollView(
                child: SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Center(
                    child: Text(
                      'Timetable Content',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Tab 2: Trips
              const SingleChildScrollView(
                child: SizedBox(
                  height: 300, // Adjust the height as needed
                  child: Center(
                    child: Text(
                      'Trips Content',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
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
