import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                const SizedBox(width: 8.0),
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
                const SizedBox(width: 8.0),
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
                  'lib/assets/icons/healthicons_walking_icon.svg',
                  width: 24.0,
                  height: 24.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    openTime,
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
