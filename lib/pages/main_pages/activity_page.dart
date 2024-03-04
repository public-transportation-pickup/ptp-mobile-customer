import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import HapticFeedback
import 'package:capstone_ptp/pages/main_pages/components/list_orders_tab.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  //CLASS VARIABLES
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  //  handle tab click
  void _handleTabClick(int index) {
    HapticFeedback.mediumImpact();
    // Switch to the selected tab
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCCF59),
        title: const Text(
          'Hoạt động',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  _buildTab('Chờ xác nhận', 0),
                  _buildTab('Đang chuẩn bị', 1),
                  _buildTab('Đã hoàn thành', 2),
                ],
                unselectedLabelColor: const Color(0xFF919191),
                labelColor: const Color(0xFFFBAB40),
                labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat'),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat'),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: const Color(0xFFFBAB40).withOpacity(0.2),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OrderListTab(orderStatus: 'Created'),
                OrderListTab(orderStatus: 'Processing'),
                OrderListTab(orderStatus: 'Completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create tabs with InkWell for haptic feedback
  Widget _buildTab(String text, int index) {
    return InkWell(
      onTap: () => _handleTabClick(index),
      child: Tab(
        text: text,
      ),
    );
  }
}
