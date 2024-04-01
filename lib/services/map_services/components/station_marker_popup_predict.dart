import 'package:capstone_ptp/models/predict_location_model.dart';
import 'package:capstone_ptp/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';

class MarkerPredictPopup extends StatelessWidget {
  final Marker marker;
  final Schedule station;
  final StoreModel store;

  const MarkerPredictPopup({
    Key? key,
    required this.marker,
    required this.station,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              'lib/assets/icons/end_search.svg',
              width: 24,
              height: 24,
            ),
          ),
          _cardDescription(),
        ],
      ),
    );
  }

  Widget _cardDescription() {
    // Parse the time using a custom method
    String formattedTime = _parseTime(station.arrivalTime!);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 80, maxWidth: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              station.stationName != "N/A"
                  ? "[${station.index}] ${station.stationName}"
                  : store.name!,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Flexible(
              child: Text(
                "Dự kiến đến trạm lúc: $formattedTime",
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _parseTime(String timeString) {
  // Split the time string into components
  List<String> components = timeString.split(':');

  // Ensure that there are enough components
  if (components.length < 2) {
    return 'Invalid time format';
  }

  // Extract hours and minutes
  int hours = int.parse(components[0]);
  int minutes = int.parse(components[1]);

  // Construct the formatted time string
  String formattedTime =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

  return formattedTime;
}
