import 'package:capstone_ptp/models/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';

class StationMarkerPopup extends StatefulWidget {
  final Marker marker;
  final StationModel station;

  const StationMarkerPopup({
    Key? key,
    required this.marker,
    required this.station,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StationMarkerPopupState();
}

class _StationMarkerPopupState extends State<StationMarkerPopup> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: SvgPicture.asset(
              'lib/assets/icons/end_search.svg',
              width: 24,
              height: 24,
              // You can adjust other properties as needed, such as color
            ),
          ),
          _cardDescription(context),
        ],
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.station.name,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              widget.station.address,
              style: const TextStyle(fontSize: 12.0),
            ),
            // Text(
            //   '${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
            //   style: const TextStyle(fontSize: 12.0),
            // ),
          ],
        ),
      ),
    );
  }
}
