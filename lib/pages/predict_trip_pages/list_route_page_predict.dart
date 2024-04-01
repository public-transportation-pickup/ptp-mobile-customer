import 'package:animations/animations.dart';
import 'package:capstone_ptp/services/api_services/route_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../models/route_model.dart';
import '../route_pages/components/card_component.dart';
import '../route_pages/components/search_bar_by_name_component.dart';
import 'route_detail_page_predict.dart';

class ListRoutePredictPage extends StatefulWidget {
  @override
  _ListRoutePredictPageState createState() => _ListRoutePredictPageState();
}

class _ListRoutePredictPageState extends State<ListRoutePredictPage> {
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
          'Chọn tuyến xe bạn đang đi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder: (_, animation, secondaryAnimation) {
                                return SharedAxisTransition(
                                  animation: animation,
                                  secondaryAnimation: secondaryAnimation,
                                  transitionType:
                                      SharedAxisTransitionType.horizontal,
                                  child: RouteDetailPredictPage(
                                      routeId: _displayedRoutes[index].id),
                                );
                              },
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
