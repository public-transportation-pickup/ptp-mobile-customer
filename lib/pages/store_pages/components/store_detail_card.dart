import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class StoreDetailCard extends StatelessWidget {
  final String storeName;
  final String description;
  final String phone;
  final String fullAddress;
  final String openTime;
  final String closeTime;

  StoreDetailCard({
    required this.storeName,
    required this.description,
    required this.phone,
    required this.fullAddress,
    required this.openTime,
    required this.closeTime,
  });

  String _formatTime(String time) {
    DateTime now = DateTime.now();
    DateTime formatedTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateFormat('HH:mm').parse(time).hour,
        DateFormat('HH:mm').parse(time).minute);
    return DateFormat('HH:mm').format(formatedTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 16.0,
            ),
            //============================
            const SizedBox(height: 8.0),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/subway_location_icon.svg',
                  width: 24.0,
                  height: 24.0,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    fullAddress,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 16.0,
            ),
            //============================
            const SizedBox(height: 8.0),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/store_phone_icon.svg',
                  width: 24.0,
                  height: 24.0,
                  color: Colors.blueAccent,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 16.0,
            ),
            //============================
            const SizedBox(height: 8.0),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/clock_icon.svg',
                  width: 24.0,
                  height: 24.0,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    "${_formatTime(openTime)} - ${_formatTime(closeTime)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
