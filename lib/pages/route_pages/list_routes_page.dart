import 'package:flutter/material.dart';
import '../../models/route_model.dart';
import '../../services/api_services.dart';
import 'components/card_component.dart';
import 'components/search_bar_by_name_component.dart';

class ListRoutePage extends StatefulWidget {
  @override
  _ListRoutePageState createState() => _ListRoutePageState();
}

class _ListRoutePageState extends State<ListRoutePage> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routeNoController = TextEditingController();
  List<RouteModel> _allRoutes = [];
  List<RouteModel> _displayedRoutes = [];

  late Future<List<RouteModel>> _fetchRoutesFuture;

  @override
  void initState() {
    _fetchRoutesFuture = _fetchRoutes();
    super.initState();
  }

  Future<List<RouteModel>> _fetchRoutes() async {
    try {
      List<RouteModel> routes = await ApiService.getRoutes();
      setState(() {
        _allRoutes = routes;
        _displayedRoutes.addAll(_allRoutes);
      });
      return routes;
    } catch (e) {
      print('Error fetching routes: $e');
      rethrow;
    }
  }

  void _filterRoutes() {
    String routeName = _routeNameController.text.toLowerCase();
    String routeNo = _routeNoController.text.toLowerCase();

    setState(() {
      _displayedRoutes = _allRoutes.where((route) {
        return (route.routeNo.toLowerCase().contains(routeNo) ||
                route.name.toLowerCase().contains(routeNo)) &&
            (route.name.toLowerCase().contains(routeName) ||
                route.routeNo.toLowerCase().contains(routeName));
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
          SearchBarByNameComponent(
            routeName: _routeNameController,
            routeNo: _routeNoController,
            onFilter: _filterRoutes,
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchRoutesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: _displayedRoutes.length,
                    itemBuilder: (context, index) {
                      return RouteCardComponent(
                        startLocation: _displayedRoutes[index].inboundName,
                        endLocation: _displayedRoutes[index].outBoundName,
                        nameRoute: _displayedRoutes[index].name,
                        numberRoute: _displayedRoutes[index].routeNo,
                        operationTime: _displayedRoutes[index].operationTime,
                        onTap: () {
                          // Handle card tap if needed
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
