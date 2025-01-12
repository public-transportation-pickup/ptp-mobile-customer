import 'package:capstone_ptp/pages/main_pages/components/carousel_slider.dart';
import 'package:capstone_ptp/pages/map_pages/map_page.dart';
import 'package:capstone_ptp/pages/route_pages/final_station_page.dart';
import 'package:capstone_ptp/services/map_services/mini_map_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';

import '../../models/order_again_model.dart';
import '../../services/api_services/order_api.dart';
import '../chart_pages/statistic_page.dart';
import '../predict_trip_pages/list_route_page_predict.dart';
import '../route_pages/list_routes_page.dart';
import '../store_pages/list_stores_page.dart';
import 'components/notify_topic_component.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final Future<List<OrderAgainItem>> orderAgainListFuture;
  final Future<List<ProductAgainItem>> productAgainListFuture;

  _HomePageState()
      : orderAgainListFuture =
            _fetchLists().then((lists) => lists[0] as List<OrderAgainItem>),
        productAgainListFuture =
            _fetchLists().then((lists) => lists[1] as List<ProductAgainItem>);

  static Future<List<List<dynamic>>> _fetchLists() async {
    try {
      final OrderAgainModel orderAgainModel = await OrderApi.getOrdersAgain();
      final List<OrderAgainItem> orderAgainList =
          orderAgainModel.orders!.map((order) {
        // Parse the pickup time string to DateTime
        DateTime pickupDateTime = DateTime.parse(order.pickUpTime!);
        // Format the DateTime to your desired format
        String formattedPickupTime =
            DateFormat('HH:mm - dd/MM/yyyy').format(pickupDateTime);

        return OrderAgainItem(
          orderId: order.id!,
          storeName: order.storeName!,
          pickUpTime: formattedPickupTime,
        );
      }).toList();

      final List<ProductAgainItem> productAgainList =
          orderAgainModel.products!.map((product) {
        return ProductAgainItem(
          productName: product.name!,
          imageUrl: product.imageURL!,
          orderCount: product.orderCount!,
          price: product.actualPrice!,
        );
      }).toList();

      return [orderAgainList, productAgainList];
    } catch (e) {
      print('Error fetching lists: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                                builder: (context) => ListStoresPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 50, // 50% of 131 (total height)
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFEFC8),
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
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'lib/assets/images/store_icon.png',
                                  ),
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
                                      'CỬA HÀNG',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      'Các cửa hàng đang hoạt động',
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
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpendingStatisticsPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 50, // 50% of 131 (total height)
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFEFC8),
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
                                  'lib/assets/images/combo_chart_icon.png',
                                  height: 20,
                                  //fit: BoxFit.cover,
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
                                      'CHI TIÊU',
                                      style: TextStyle(
                                        color: Color(0xFF353434),
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      'Thống kê chi tiêu, giao dịch',
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
                                color: Color(0xFFFFEFC8),
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
                                child: SvgPicture.asset(
                                  'lib/assets/images/detect_trip_icon.svg',
                                  color: Colors.blueGrey,
                                  //height: 20,
                                  //fit: BoxFit.cover,
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

            FutureBuilder(
              future:
                  Future.wait([orderAgainListFuture, productAgainListFuture]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                      'Có lỗi xảy ra, vui lòng thử lại:\n${snapshot.error}');
                } else {
                  // Check if both futures are null
                  bool isDataAvailable = snapshot.data![0].isEmpty;

                  if (isDataAvailable) {
                    return const Center(
                      child: SizedBox(),
                    );
                  } else {
                    // SLIDER "Đặt lại món"
                    Widget suggestionSlider = Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Các món mua thường xuyên',
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
                                child: CustomCarouselSlider(
                                  productAgainListFuture:
                                      productAgainListFuture,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );

                    // Đặt lại đơn
                    Widget orderAgainComponent = Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đặt lại đơn',
                            style: TextStyle(
                              color: Color(0xFF353434),
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          NotifyTopicComponent(
                              orderAgainListFuture: orderAgainListFuture),
                        ],
                      ),
                    );

                    return Column(
                      children: [
                        suggestionSlider,
                        orderAgainComponent,
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
