import 'package:capstone_ptp/models/order_model.dart';
import 'package:capstone_ptp/services/api_services/order_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../order_pages/order_detail_page.dart';

class TimeOutOrderTab extends StatefulWidget {
  @override
  _TimeOutOrderTabState createState() => _TimeOutOrderTabState();
}

class _TimeOutOrderTabState extends State<TimeOutOrderTab> {
  //CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  late Future<List<OrderModel>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = _fetchOrders();
  }

  Future<List<OrderModel>> _fetchOrders() async {
    try {
      List<OrderModel> allOrders = await OrderApi.getOrdersOfUser();
      return allOrders
          .where((order) => order.status == 'PickUpTimeOut')
          .toList();
    } catch (error) {
      checkLog.e('Error fetching orders: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: _futureOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<OrderModel>? orders = snapshot.data;
          if (orders != null && orders.isNotEmpty) {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return TransactionCard(order: orders[index]);
              },
            );
          } else {
            return const Center(child: Text('Không có đơn hàng nào.'));
          }
        }
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  final OrderModel order;

  TransactionCard({required this.order});

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  String formatDate(String date) {
    DateTime creationDate = DateTime.parse(date);
    String formattedDate =
        DateFormat('HH:mm - dd/MM/yyyy').format(creationDate);
    return formattedDate;
  }

  String formatDateToDate(DateTime date) {
    String formattedDate = DateFormat('HH:mm - dd/MM/yyyy').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Navigate to OrderDetailPage and pass the order uuid
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailPage(orderUuid: order.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.timer_off,
                  color: Colors.brown,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.storeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Tổng cộng: ${formatPrice(order.total)}'),
                    Text(formatDateToDate(order.pickUpTime)),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Xem chi tiết",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
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
