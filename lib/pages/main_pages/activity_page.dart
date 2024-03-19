import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 4,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Lịch sử hoạt động',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: Color(0xFFFCCF59),
                indicatorColor: Color(0xFFFCCF59),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(text: 'Lịch sử thanh toán'),
                  Tab(text: 'Đơn đã nhận'),
                  Tab(text: 'Đơn bị hủy'),
                  Tab(text: 'Đơn quá hạn'),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Center(child: Text('Transaction History')),
                  Center(child: Text('Completed Orders')),
                  Center(child: Text('Canceled Orders')),
                  Center(child: Text('Payment Orders')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
