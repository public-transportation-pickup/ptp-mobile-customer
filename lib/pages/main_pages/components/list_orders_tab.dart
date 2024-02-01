import 'package:flutter/material.dart';

class OrderListTab extends StatelessWidget {
  final String orderStatus;

  OrderListTab({required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    // Replace this with your logic to fetch orders based on orderStatus
    // For example, you can use FutureBuilder to fetch orders asynchronously
    // and display them in a ListView.

    // Dummy data for demonstration
    List<String> orders = [];

    return orders.isEmpty
        ? Center(
            child: Text('You don\'t have any $orderStatus orders.'),
          )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              // Replace this with your order item widget
              return ListTile(
                title: Text(orders[index]),
                // Add more order details as needed
              );
            },
          );
  }
}
