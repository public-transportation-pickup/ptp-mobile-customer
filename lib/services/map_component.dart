import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapComponent extends StatefulWidget {
  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final MapController _mapController = MapController();
  LocationData? _currentLocation;
  bool _isLoading = true;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
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
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always,
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
