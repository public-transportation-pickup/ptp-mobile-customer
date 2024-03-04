import 'package:capstone_ptp/pages/main_pages/components/order_card_component.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../models/order_model.dart';
import '../../../services/api_services.dart';

// ignore: must_be_immutable
class OrderListTab extends StatelessWidget {
  //CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  //CLASS VARIABLES
  final String orderStatus;
  //TEST
  // Mock data for demo UI
  List<OrderModel> demoOrders = [
    OrderModel(
      id: '1',
      name: 'John Doe',
      phoneNumber: '123-456-7890',
      pickUpTime: DateTime.now().add(Duration(days: 1)),
      total: 50.0,
      status: 'Created',
      userId: 'user123',
      stationId: 'station456',
      stationName: 'Station A',
      stationAddress: '123 Main St, Cityville',
      storeId: 'store789',
      storeName: 'Jollibee - TTTM Coopmart Xa Lộ Hà Nội',
      storePhoneNumber: '987-654-3210',
      paymentId: 'payment123',
      paymentType: 'Credit Card',
      paymentStatus: 'Paid',
    ),
    OrderModel(
      id: '2',
      name: 'Jane Smith',
      phoneNumber: '987-654-3210',
      pickUpTime: DateTime.now().add(Duration(days: 2)),
      total: 75.0,
      status: 'Completed',
      userId: 'user456',
      stationId: 'station789',
      stationName: 'Station B',
      stationAddress: '456 Oak St, Townsville',
      storeId: 'store012',
      storeName: 'Store Y',
      storePhoneNumber: '123-456-7890',
      paymentId: 'payment456',
      paymentType: 'PayPal',
      paymentStatus: 'Completed',
    ),
    OrderModel(
      id: '3',
      name: 'Jane Smith',
      phoneNumber: '987-654-3210',
      pickUpTime: DateTime.now().add(Duration(days: 2)),
      total: 75.0,
      status: 'Processing',
      userId: 'user456',
      stationId: 'station789',
      stationName: 'Station B',
      stationAddress: '456 Oak St, Townsville',
      storeId: 'store012',
      storeName: 'Store Y',
      storePhoneNumber: '123-456-7890',
      paymentId: 'payment456',
      paymentType: 'PayPal',
      paymentStatus: 'Completed',
    ),
    // Add more demo orders as needed
  ];

  OrderListTab({required this.orderStatus});

  Future<List<OrderModel>> _fetchOrders() async {
    try {
      List<OrderModel> allOrders = await ApiService.getOrdersOfUser();
      return allOrders;
    } catch (error) {
      checkLog.e('Error fetching orders: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: _fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return const Center(child: Text('Có lỗi xảy ra vui lòng thử lại!'));
          // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(
          //     child: Text('You don\'t have any $orderStatus orders.'),
          //   );
        } else {
          List<OrderModel> orders = demoOrders; //snapshot.data!;
          List<OrderModel> filteredOrders =
              orders.where((order) => order.status == orderStatus).toList();

          return ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              return OrderCardComponent(order: filteredOrders[index]);
            },
          );
        }
      },
    );
  }
}
