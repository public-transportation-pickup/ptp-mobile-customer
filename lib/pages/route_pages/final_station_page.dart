import 'package:capstone_ptp/pages/route_pages/route_detail_page.dart';
import 'package:capstone_ptp/services/api_services/station_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../models/route_model.dart';
import 'components/card_component.dart';
import 'components/search_bar_by_station_name.dart';

class FinalStationPage extends StatefulWidget {
  final String? initialValue;
  FinalStationPage({this.initialValue});
  @override
  _FinalStationPageState createState() => _FinalStationPageState();
}

class _FinalStationPageState extends State<FinalStationPage> {
  var checkLog = Logger(printer: PrettyPrinter());
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<RouteModel> _routes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialValue ?? '';
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _searchRoutes(String stationName) async {
    setState(() {
      _isLoading = true;
      _routes.clear(); // Clear previous search results
    });

    try {
      List<RouteModel> routes =
          await StationApi.getRoutesByStationName(stationName);
      setState(() {
        _routes = routes;
        _isLoading = false;
      });
    } catch (e) {
      checkLog.e('Error fetching routes: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tìm tuyến theo trạm',
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
          SearchBarByStationNameComponent(
            routeName: _searchController,
            focusNode: _searchFocusNode,
            onFilter: () => _searchRoutes(_searchController.text),
          ),
          if (_isLoading)
            const CircularProgressIndicator()
          else if (_routes.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Không tìm thấy tuyến nào!'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _routes.length,
                itemBuilder: (context, index) {
                  return RouteCardComponent(
                    startLocation: _routes[index].inboundName,
                    endLocation: _routes[index].outBoundName,
                    nameRoute: _routes[index].name,
                    numberRoute: _routes[index].routeNo,
                    operationTime: _routes[index].operationTime,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteDetailPage(
                            routeId: _routes[index].id,
                          ),
                        ),
                      );
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
