import 'package:capstone_ptp/pages/route_pages/route_detail_page.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../models/route_model.dart';
import 'components/card_component.dart';
import 'components/search_bar_by_name_component.dart';

class ListRoutePage extends StatefulWidget {
  @override
  _ListRoutePageState createState() => _ListRoutePageState();
}

class _ListRoutePageState extends State<ListRoutePage> {
  //CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  //CLASS VARIABLES
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
      List<RouteModel> routes = await RouteApi.getRoutes();
      setState(() {
        _allRoutes = routes.reversed.toList();
        _displayedRoutes.addAll(_allRoutes);
      });
      return routes;
    } catch (e) {
      checkLog.e('Error fetching routes: $e');
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
          'Chọn tuyến xe buýt',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteDetailPage(
                                  routeId: _displayedRoutes[index].id),
                            ),
                          );
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
