import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class RouteCardDetailComponent extends StatelessWidget {
  final String startLocation = "Suoi Tien";
  final String endLocation = "Thu Duc";
  final String nameRoute = "Bến xe buýt Chợ Lớn - Đại học Giao thông Vận tải";
  final String numberRoute = "51";
  final String operationTime = "7:00 - 21:00";
  //final Function() onTap;

  // RouteCardDetailComponent({
  //   required this.startLocation,
  //   required this.endLocation,
  //   required this.nameRoute,
  //   required this.numberRoute,
  //   required this.operationTime,
  //   required this.onTap,
  // });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: InkWell(
        //onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'lib/assets/icons/yellow_clock_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              operationTime,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Handle tap, navigate to another page, etc.
                              },
                              child: const Text(
                                'Lượt đi ^',
                                style: TextStyle(
                                  color: Color(0xFFFCCF59),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
