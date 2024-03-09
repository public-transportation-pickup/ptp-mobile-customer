import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RouteCardComponent extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String nameRoute;
  final String numberRoute;
  final String operationTime;
  final Function() onTap;

  RouteCardComponent({
    required this.startLocation,
    required this.endLocation,
    required this.nameRoute,
    required this.numberRoute,
    required this.operationTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: const Color(0xFFFCCF59),
                        width: 5.0,
                      ),
                    ),
                    child: Text(
                      numberRoute.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameRoute,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'lib/assets/icons/yellow_clock_icon.svg',
                              width: 20,
                              height: 20,
                              //color: Colors.black87,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              operationTime,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    // Handle tap, navigate to another page, etc.
                  },
                  child: const Text(
                    'Xem chi tiết >',
                    style: TextStyle(
                      color: Color(0xFFFCCF59),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
