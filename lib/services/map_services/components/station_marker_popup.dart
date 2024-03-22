import 'package:capstone_ptp/models/station_model.dart';
import 'package:capstone_ptp/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';

class MarkerPopup extends StatelessWidget {
  final Marker marker;
  final StationModel station;
  final StoreModel store;

  const MarkerPopup({
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
              station.name != "N/A" ? station.name! : store.name,
              //overflow: TextOverflow.ellipsis,
              //softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              station.address != "N/A"
                  ? station.address!
                  : "${store.addressNo} ${store.street}, ${store.ward}, ${store.zone}",
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
