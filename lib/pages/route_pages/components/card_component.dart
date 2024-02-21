import 'package:flutter/material.dart';

class RouteCardComponent extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String nameRoute;
  final int numberRoute;
  final String startTime;
  final String endTime;
  final Function() onTap;

  RouteCardComponent({
    required this.startLocation,
    required this.endLocation,
    required this.nameRoute,
    required this.numberRoute,
    required this.startTime,
    required this.endTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        fontSize: 32,
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
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('Start: $startTime'),
                            Text(' - End: $endTime'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('From: $startLocation'),
                            Text(' - To: $endLocation'),
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
                      fontSize: 12,
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
