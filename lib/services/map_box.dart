// import 'package:flutter/material.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const FullMap();
//   }
// }

// class FullMap extends StatefulWidget {
//   const FullMap();

//   @override
//   State createState() => FullMapState();
// }

// class FullMapState extends State<FullMap> {
//   MapboxMap? mapboxMap;

//   _onMapCreated(MapboxMap mapboxMap) {
//     this.mapboxMap = mapboxMap;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: MapWidget(
//       key: const ValueKey("mapWidget"),
//       resourceOptions: ResourceOptions(
//           accessToken:
//               'pk.eyJ1IjoicHRuZ2hpYTM1MDIiLCJhIjoiY2x0NWt6aTE4MDFzeTJpbWwwYnBpYTZxdiJ9.ccjKntJzNYlj3VnDHoThsw'),
//       onMapCreated: _onMapCreated,
//     ));
//   }
// }
