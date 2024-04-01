import 'package:capstone_ptp/pages/map_pages/map_page.dart';
import 'package:capstone_ptp/pages/route_pages/final_station_page.dart';
import 'package:capstone_ptp/services/map_services/mini_map_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';

import '../predict_trip_pages/list_route_page_predict.dart';
import '../route_pages/list_routes_page.dart';
import '../store_pages/store_detail_page.dart';
import 'components/carousel_slider.dart';
import 'components/notify_topic_component.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: Stack(
                        children: [
                          // Background Container
                          Container(
                            width: double.infinity,
                            height: 280,
                            decoration: const ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFFCCF59), Color(0xFFFBAB40)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 7,
                                  offset: Offset(0, 4),
                                  spreadRadius: -1,
                                ),
                              ],
                            ),
                          ),
                          // Profile Icon
                          Positioned(
                            top: 48,
                            right: 32,
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                );
                              },
                              child: SvgPicture.asset(
                                'lib/assets/icons/account_icon.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          // Centered Search Bar
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FinalStationPage(
                                      initialValue: _searchController
                                          .text, // Pass the value of the text field
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEFC8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Đi đến trạm...',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFB1B1B1),
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                        top: 4, bottom: 8, left: 20),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FinalStationPage(
                                              initialValue: _searchController
                                                  .text, // Pass the value of the text field
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/tabler_search.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
                // Container for Bus / Food / Coffee
                Positioned(
                  top: 180,
                  left: (MediaQuery.of(context).size.width - 100 * 3 - 16 * 2) /
                      2,
                  // Container for Bus / Food / Coffee
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreDetailPage(
                                      storeId:
                                          '4504b5b5-2a3f-4815-a768-d166faabd33d',
                                      arrivalTime: "16:00",
                                      stationId:
                                          'd92acefd-04e1-4806-92d5-dc79402be22f',
                                    )),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 50, // 50% of 131 (total height)
                              decoration: const ShapeDecoration(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF909090),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  'lib/assets/images/bus.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 65,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF909090),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(8, 4, 0,
                                    4), // Left: 8, Top: 4, Right: 0, Bottom: 4
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'XE BUÝT',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      'Tìm trạm xe gần bạn',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 50, // 50% of 131 (total height)
                            decoration: const ShapeDecoration(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Image.asset(
                                'lib/assets/images/banhmi.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 65, // 50% of 131 (total height)
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ĐỒ ĂN',
                                    style: TextStyle(
                                      color: Color(0xFF353434),
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    'Tìm món ăn gần bạn',
                                    style: TextStyle(
                                      color: Color(0xFF353434),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListRoutePredictPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              decoration: const ShapeDecoration(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF909090),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  'lib/assets/images/cafe.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 65,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0xFF909090),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'VỊ TRÍ',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      'Định vị chuyến xe bạn đang đi',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current user location
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vị trí hiện tại',
                    style: TextStyle(
                      color: Color(0xFF353434),
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // This container is for map
                  Container(
                    height: 150,
                    color: Colors.blue,
                    child: Stack(
                      children: [
                        MiniMapComponent(),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: FloatingActionButton(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            mini: true,
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder:
                                      (_, animation, secondaryAnimation) {
                                    return SharedAxisTransition(
                                      animation: animation,
                                      secondaryAnimation: secondaryAnimation,
                                      transitionType:
                                          SharedAxisTransitionType.scaled,
                                      child: MapPage(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.zoom_out_map_rounded,
                              color: Color(0xFFFBAB40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // List of bus trip
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListRoutePage()),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          // Left side with icon
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 104,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFCCF59),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'lib/assets/icons/bus_icon.svg',
                                width: 64,
                                height: 64,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Right side with white background and text
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: 104,
                            padding: const EdgeInsets.all(16),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DANH SÁCH TUYẾN XE ',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Xem thông tin các tuyến xe buýt đang hoạt động tại TP.HCM',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalStationPage()),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          // Left side with icon
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 104,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFCCF59),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'lib/assets/icons/route_spot_guide_map.svg',
                                width: 64,
                                height: 64,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Right side with white background and text
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: 104,
                            padding: const EdgeInsets.all(16),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF909090),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TRẠM CUỐI',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Tìm tuyến xe phù hợp theo trạm mà bạn muốn đến',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // SLIDER "Gợi ý cho bạn"
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gợi ý cho bạn',
                    style: TextStyle(
                      color: Color(0xFF353434),
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomCarouselSlider(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Infomation Notifycation Topic
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Khám phá tin tức',
                        style: TextStyle(
                          color: Color(0xFF353434),
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      NotifyTopicComponent(),
                    ])),
          ],
        ),
      ),
    );
  }
}
