import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

import '../../models/station_model.dart';
import '../../models/store_model.dart';
import '../api_services/station_api.dart';
import '../api_services/store_api.dart';
import 'components/station_marker_popup.dart';

class MiniMapComponent extends StatefulWidget {
  @override
  _MiniMapComponentState createState() => _MiniMapComponentState();
}

class _MiniMapComponentState extends State<MiniMapComponent> {
  final MapController _mapController = MapController();
  LocationData? _currentLocation;
  bool _isLoading = true;
  bool _showMarkers = true;
  // CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  // MARKERS VALUE
  List<StoreModel>? _stores;
  List<StationModel>? _stations;
  List<Marker>? _markers;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getListMarkers();
  }

  Future<void> _fetchStation() async {
    try {
      List<StationModel> stationsFromApi = await StationApi.getStations();
      _stations = stationsFromApi;
    } catch (e) {
      checkLog.e('Error fetching station $e');
      rethrow;
    }
  }

  Future<List<StoreModel>> _fetchStores() async {
    try {
      List<StoreModel> stores = await StoreApi.getStores();
      _stores = stores;
      return stores;
    } catch (e) {
      checkLog.e('Error fetching stores $e');
      rethrow;
    }
  }

  Future<List<Marker>> _getListMarkers() async {
    await _fetchStation();
    await _fetchStores();
    var storeMarker = _stores
        ?.map((store) => Marker(
              height: 24,
              width: 24,
              point: LatLng(store.latitude, store.longitude),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: const Icon(
                  IconData(0xe60a, fontFamily: 'MaterialIcons'),
                  color: Colors.orange,
                  size: 16,
                ),
              ),
            ))
        .toList();

    var stationMarkers = _stations
        ?.map((station) => Marker(
              height: 24,
              width: 24,
              point: LatLng(station.latitude, station.longitude),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: const Icon(
                  IconData(0xe1d5, fontFamily: 'MaterialIcons'),
                  color: Colors.blue,
                  size: 16,
                ),
              ),
            ))
        .toList();

    List<Marker> markerList = [];
    markerList.addAll(stationMarkers ??= []);
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
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      checkLog.e("Error getting location: $e");
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
        maxZoom: 16,
        minZoom: 12,
        interactiveFlags:
            InteractiveFlag.all & ~InteractiveFlag.rotate, // cant rotate
        onPositionChanged: (position, _) {
          if (position.zoom! <= 14 && _showMarkers) {
            setState(() {
              _showMarkers = false;
              _markers = []; // Clear markers when zoom level is <=> 14
            });
          } else if (position.zoom! > 14 && !_showMarkers) {
            setState(() {
              _showMarkers = true;
              _getListMarkers(); // Populate markers
            });
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          maxZoom: 16,
          minZoom: 12,
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: _markers ?? [],
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) {
                // Find the corresponding station or store for the marker
                StationModel station = _stations!.firstWhere(
                  (s) =>
                      s.latitude == marker.point.latitude &&
                      s.longitude == marker.point.longitude,
                  orElse: () => StationModel(
                    id: "N/A",
                    addressNo: "N/A",
                    name: "N/A",
                    address: "N/A",
                    code: "N/A",
                    status: "N/A",
                    stopType: "N/A",
                    street: "N/A",
                    supportDisability: "N/A",
                    ward: "N/A",
                    zone: "N/A",
                    latitude: 0.0,
                    longitude: 0.0,
                  ),
                );

                StoreModel store = _stores!.firstWhere(
                  (s) =>
                      s.latitude == marker.point.latitude &&
                      s.longitude == marker.point.longitude,
                  orElse: () => StoreModel(
                      id: "N/A",
                      creationDate: "N/A",
                      name: "N/A",
                      description: "N/A",
                      phoneNumber: "N/A",
                      status: "N/A",
                      openedTime: "N/A",
                      closedTime: "N/A",
                      latitude: 0.0,
                      longitude: 0.0,
                      addressNo: "N/A",
                      street: "N/A",
                      zone: "N/A",
                      ward: "N/A",
                      activationDate: "N/A",
                      imageName: "N/A",
                      imageURL: "N/A",
                      userId: "N/A"),
                );

                return MarkerPopup(
                  marker: marker,
                  station: station,
                  store: store, // Pass store information to the popup
                );
              },
            ),
          ),
        ),

        //MarkerLayer(markers: _markers ?? []),
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
          if (!_isLoading && _currentLocation != null) _buildMap(),
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

          // Handle move current location button
          Positioned(
            bottom: 4,
            right: 4,
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
              shape: const CircleBorder(),
              mini: true,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.my_location,
                color: Color(0xFFFBAB40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
