import 'package:flutter/material.dart';
import 'package:capstone_ptp/services/map_services/map_with_trip.dart';
import '../../models/route_model.dart';
import '../../models/route_var_model.dart';
import '../../services/api_services/route_api.dart';
import 'components/route_detail_card.dart';
import 'components/route_detail_tab.dart';

class RouteDetailPage extends StatefulWidget {
  final String routeId;

  RouteDetailPage({required this.routeId});

  @override
  _RouteDetailPageState createState() => _RouteDetailPageState();
}

class _RouteDetailPageState extends State<RouteDetailPage> {
  late Future<RouteModel> _routeDetail;
  late Future<List<RouteVarModel>> _routeVars;
  String? currentRouteVar;

  Key _routeDetailTabKey = UniqueKey();

  // ignore: unused_field
  List<RouteVarModel> _allRouteVars = [];
  String routeVarTurnGo = '';
  String routeVarTurnBack = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _routeDetail = RouteApi.getRouteDetail(widget.routeId);
    _routeVars = RouteApi.getRouteVarsByRouteId(widget.routeId);

    // Wait for both futures to complete
    await Future.wait([_routeDetail, _routeVars]);

    List<RouteVarModel> routeVars = await _routeVars;

    setState(() {
      // Update the state variables after the futures are complete
      _allRouteVars = routeVars;
      routeVarTurnGo = routeVars.isNotEmpty ? routeVars[0].id : 'No value go';
      routeVarTurnBack =
          routeVars.length > 1 ? routeVars[1].id : 'No value back';
      currentRouteVar = routeVarTurnGo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _routeDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chi tiết chuyến'),
              centerTitle: true,
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
            body: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chi tiết chuyến'),
              centerTitle: true,
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
            body: _buildBody(snapshot),
          );
        }
      },
    );
  }

  Widget _buildBody(AsyncSnapshot<RouteModel> snapshot) {
    if (currentRouteVar == null) {
      // Handle case where currentRouteVar is null
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasData) {
      return Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: MapWithTripComponent(
                routeVarId: currentRouteVar!,
                key: UniqueKey(),
              ),
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.15,
            maxChildSize: 0.9,
            initialChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Stack(children: [
                        RouteCardDetailComponent(routeDetail: snapshot.data!),
                        Positioned(
                          right: 20.0,
                          bottom: 20.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle between routeVarTurnGo and routeVarTurnBack
                                currentRouteVar =
                                    (currentRouteVar == routeVarTurnGo)
                                        ? routeVarTurnBack
                                        : routeVarTurnGo;
                                // Update the key to trigger a rebuild of RouteDetailTab
                                _routeDetailTabKey = UniqueKey();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: (currentRouteVar == routeVarTurnGo)
                                    ? Colors.blue[50]
                                    : Colors.green[50],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.swap_vert,
                                    color: (currentRouteVar == routeVarTurnGo)
                                        ? Colors.blue
                                        : Colors.green,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    (currentRouteVar == routeVarTurnGo)
                                        ? "Lượt đi"
                                        : "Lượt về",
                                    style: TextStyle(
                                      color: (currentRouteVar == routeVarTurnGo)
                                          ? Colors.blue
                                          : Colors.green,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        color: Colors.white,
                        child: RouteDetailTab(
                          key: _routeDetailTabKey,
                          routeDetail: snapshot.data!,
                          currentRouteVar: currentRouteVar!,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      return const Center(child: Text('No data available'));
    }
  }
}
