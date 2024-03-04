import 'package:capstone_ptp/pages/main_pages/components/order_card_component.dart';
import 'package:capstone_ptp/services/api_services/order_api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../models/order_model.dart';

// ignore: must_be_immutable
class OrderListTab extends StatelessWidget {
  //CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  //CLASS VARIABLES
  final String orderStatus;

  OrderListTab({required this.orderStatus});

  Future<List<OrderModel>> _fetchOrders() async {
    try {
      List<OrderModel> allOrders = await OrderApi.getOrdersOfUser();
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
          return const Center(child: Text('Có lỗi xảy ra vui lòng thử lại!'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Bạn không có bất kì đơn hàng nào.'),
          );
        } else {
          List<OrderModel> orders = snapshot.data!;
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
