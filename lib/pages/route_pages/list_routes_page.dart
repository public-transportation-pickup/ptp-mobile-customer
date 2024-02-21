import 'package:flutter/material.dart';
import 'components/card_component.dart';
import 'components/search_bar_component.dart';

class ListRoutePage extends StatefulWidget {
  @override
  _ListRoutePageState createState() => _ListRoutePageState();
}

class _ListRoutePageState extends State<ListRoutePage> {
  TextEditingController _startPointController = TextEditingController();
  TextEditingController _endPointController = TextEditingController();
  List<RouteItem> _allRoutes = [];
  List<RouteItem> _displayedRoutes = [];

  @override
  void initState() {
    _allRoutes = [
      RouteItem(
          startPoint: 'A',
          endPoint: 'B',
          nameRoute: 'Bến xe buýt Chợ Lớn - Đại học Giao thông Vận tải',
          numberRoute: 56,
          startTime: '5:00',
          endTime: '21:00'),
      RouteItem(
          startPoint: 'B',
          endPoint: 'C',
          nameRoute: 'Bến xe Suối tiên',
          numberRoute: 88,
          startTime: '5:00',
          endTime: '22:00'),
      RouteItem(
          startPoint: 'C',
          endPoint: 'D',
          nameRoute: 'Bến xe buýt Chợ Lớn - Đại học Nông Lâm',
          numberRoute: 02,
          startTime: '6:00',
          endTime: '19:00'),
      RouteItem(
          startPoint: 'C',
          endPoint: 'D',
          nameRoute: 'Bến xe buýt Test',
          numberRoute: 69,
          startTime: '6:00',
          endTime: '19:00'),
      RouteItem(
          startPoint: 'C',
          endPoint: 'D',
          nameRoute:
              'Bến xe buýt một cái gì đó dài thiệt là dài mà cái box không chứa hết chữ ahihi ahuhu',
          numberRoute: 25,
          startTime: '6:00',
          endTime: '19:00'),
      // Add more routes as needed
    ];

    _displayedRoutes.addAll(_allRoutes);

    super.initState();
  }

  void _filterRoutes() {
    String startQuery = _startPointController.text.toLowerCase();
    String endQuery = _endPointController.text.toLowerCase();

    setState(() {
      _displayedRoutes = _allRoutes.where((route) {
        return (route.startPoint.toLowerCase().contains(startQuery) ||
                startQuery.isEmpty) &&
            (route.endPoint.toLowerCase().contains(endQuery) ||
                endQuery.isEmpty);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn tuyến',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          SearchBarComponent(
            startPointController: _startPointController,
            endPointController: _endPointController,
            onFilter: _filterRoutes,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _displayedRoutes.length,
              itemBuilder: (context, index) {
                return RouteCardComponent(
                  startLocation: _displayedRoutes[index].startPoint,
                  endLocation: _displayedRoutes[index].endPoint,
                  nameRoute: _displayedRoutes[index].nameRoute,
                  numberRoute: _displayedRoutes[index].numberRoute,
                  startTime: _displayedRoutes[index].startTime,
                  endTime: _displayedRoutes[index].endTime,
                  onTap: () {
                    // Handle card tap if needed
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RouteItem {
  final String startPoint;
  final String endPoint;

  final String nameRoute;
  final int numberRoute;
  final String startTime;
  final String endTime;

  RouteItem(
      {required this.startPoint,
      required this.endPoint,
      required this.startTime,
      required this.endTime,
      required this.nameRoute,
      required this.numberRoute});
}
