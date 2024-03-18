import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

import '../models/station_model.dart';
import '../models/store_model.dart';
import 'api_services/station_api.dart';
import 'api_services/store_api.dart';

class MapComponent extends StatefulWidget {
  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final MapController _mapController = MapController();
  LocationData? _currentLocation;
  bool _isLoading = true;

  List<StoreModel>? _stores;
  List<StationModel>? _stations;
  List<Marker>? _markers;

  List<LatLng> points = [
    const LatLng(10.7512531281, 106.6525650024),
    const LatLng(10.750232, 106.652554),
    const LatLng(10.750732, 106.655075),
    const LatLng(10.751368, 106.659203),
  ];

  var log = Logger(printer: PrettyPrinter());

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getListMarkers();
  }

  Future<void> _fetchStation() async {
    try {
      List<StationModel> stationsFromApi = await StationApi.getStations();

      _stations = stationsFromApi;
    } catch (e) {
      log.e('Error fetching station $e');
      rethrow;
    }
  }

  Future<List<StoreModel>> _fetchStores() async {
    try {
      List<StoreModel> stores = await StoreApi.getStores();
      _stores = stores;
      return stores;
    } catch (e) {
      log.e('Error fetching stores $e');
      rethrow;
    }
  }

  Future<List<Marker>> getListMarkers() async {
    await _fetchStation();
    await _fetchStores();
    var storeMarker = _stores
        ?.map((store) => Marker(
              point: LatLng(store.latitude, store.longitude),
              child: const Icon(
                IconData(0xe60a, fontFamily: 'MaterialIcons'),
              ),
              width: 10,
              height: 10,
            ))
        .toList();
    // var stationMarkers = _stations
    //     ?.map((station) => Marker(
    //           point: LatLng(station.latitude, station.longitude),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               shape: BoxShape.circle,
    //               border: Border.all(
    //                 color: Colors.orange,
    //                 width: 2,
    //               ),
    //             ),
    //             child: const Icon(
    //               IconData(0xe1d5, fontFamily: 'MaterialIcons'),
    //               color: Colors.orange,
    //               size: 16,
    //             ),
    //           ),
    //         ))
    //     .toList();

    List<Marker> markerList = [];
    //markerList.addAll(stationMarkers ??= []);
    markerList.addAll(storeMarker ??= []);
    setState(() {
      _isLoading = false;
      _markers = markerList;
    });
    return markerList;
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    try {
      LocationData currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
        _isLoading = false;
      });

      if (_currentLocation != null) {
        _mapController.move(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15.0,
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error getting location: $e");
    }
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        ),
        initialZoom: 15,
        maxZoom: 19,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          maxZoom: 19,
        ),
        TappablePolylineLayer(
            // Will only render visible polylines, increasing performance
            polylineCulling: true,
            pointerDistanceTolerance: 20,
            polylines: [
              TaggedPolyline(
                tag: 'My Polyline',
                // An optional tag to distinguish polylines in callback
                points: points,
                color: Colors.red,
                strokeWidth: 9.0,
              ),
              // TaggedPolyline(
              //   tag: 'My 2nd Polyline',
              //   // An optional tag to distinguish polylines in callback
              //   points: getPoints(1),
              //   color: Colors.black,
              //   strokeWidth: 3.0,
              // ),
            ],
            onTap: (polylines, tapPosition) => log.d(
                'Tapped: ${polylines.map((polyline) => polyline.tag).join(',')} at ${tapPosition.globalPosition}'),
            onMiss: (tapPosition) {
              log.d(
                  'No polyline was tapped at position ${tapPosition.globalPosition}');
            }),
        MarkerLayer(markers: _markers ?? []),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.never,
          alignDirectionOnUpdate: AlignOnUpdate.never,
          style: const LocationMarkerStyle(
            marker: DefaultLocationMarker(
              child: Icon(
                Icons.navigation,
                color: Colors.white,
                size: 15,
              ),
            ),
            markerSize: Size(24, 24),
            markerDirection: MarkerDirection.heading,
            showAccuracyCircle: true,
            accuracyCircleColor: Color.fromARGB(128, 189, 189, 254),
            showHeadingSector: true,
            headingSectorColor: Color.fromARGB(128, 80, 80, 254),
            headingSectorRadius: 60,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (!_isLoading && _currentLocation != null && _markers != null)
            _buildMap(),
          // Check map load
          if (_isLoading)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Đang tải..."),
                  ],
                ),
              ),
            ),

          // Hangle logic button
          Positioned(
            bottom: 4,
            left: 4,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                if (_currentLocation != null) {
                  _mapController.move(
                    LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    15.0,
                  );
                }
              },
              mini: true,
              backgroundColor: const Color(0xFFFBAB40),
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    // Implement the zoom-in functionality here
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                  mini: true,
                  backgroundColor: const Color(0xFFFBAB40),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    // Implement the zoom-out functionality here
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                  mini: true,
                  backgroundColor: const Color(0xFFFBAB40),
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
