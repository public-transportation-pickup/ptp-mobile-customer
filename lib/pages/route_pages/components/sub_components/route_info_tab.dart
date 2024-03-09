import 'package:capstone_ptp/models/route_model.dart';
import 'package:flutter/material.dart';

class RouteInfoTab extends StatelessWidget {
  final RouteModel routeDetail;

  RouteInfoTab({required this.routeDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(context, 'Đơn vị đảm nhận:', routeDetail.orgs),
            _buildDivider(),
            _buildRow(context, 'Cự ly:', '${routeDetail.distance} m'),
            _buildDivider(),
            _buildRow(context, 'Số chuyến:', routeDetail.totalTrip),
            _buildDivider(),
            _buildRow(context, 'Thời gian chuyến:', routeDetail.operationTime),
            _buildDivider(),
            _buildRow(
                context, 'Giãn cách chuyến:', '${routeDetail.headWay} phút'),
            // Add more rows and dividers as needed
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    // remove </br> from value
    value = value.replaceAll(RegExp(r'<br/>'), '\n');
    // change TPD
    value = value.replaceAll("[TPD]", "chuyến/ngày");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
      height: 16.0,
    );
  }
}
