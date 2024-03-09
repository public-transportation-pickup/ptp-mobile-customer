import 'package:capstone_ptp/services/mini_map_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/route_model.dart';
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
  //late Future<List<RouteVarModel>> _routeVars;
  //late Future<List<TripModel>> _trips;

  @override
  void initState() {
    super.initState();
    _routeDetail = RouteApi.getRouteDetail(widget.routeId);
    //_routeVars = RouteApi.getRouteVarsByRouteId(widget.routeId);
    // You may replace 'yourRouteVarId' with the actual routeVarId you want to fetch trips for
    //_trips = RouteApi.getTrips(widget.routeId, 'yourRouteVarId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết chuyến'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _routeDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                        child: MiniMapComponent(),
                      ),
                    ),
                    DraggableScrollableSheet(
                      minChildSize: 0.15,
                      maxChildSize: 0.9,
                      initialChildSize: 0.4,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
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
                                RouteCardDetailComponent(
                                    routeDetail: snapshot.data!),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    color: Colors.white,
                                    child: RouteDetailTab(
                                        routeDetail: snapshot.data!)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            }));
  }
}
