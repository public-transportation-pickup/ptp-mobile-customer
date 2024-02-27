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
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error fetching orders: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('You don\'t have any $orderStatus orders.'),
          );
        } else {
          List<OrderModel> orders = snapshot.data!;
          List<OrderModel> filteredOrders =
              orders.where((order) => order.status == orderStatus).toList();

          return ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              // Replace this with your order item widget
              return ListTile(
                title: Text(filteredOrders[index].name),
                // Add more order details as needed
              );
            },
          );
        }
      },
    );
  }
}
