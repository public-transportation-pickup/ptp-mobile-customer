import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;

import '../../../models/order_model.dart';
import '../../../services/api_services/order_api.dart';

import '../../../utils/order_count.dart';
import '../components/order_card_component.dart';

class OrderListTab extends StatefulWidget {
  final String orderStatus;
  final OrderCountNotifier orderCountNotifier;

  OrderListTab({required this.orderStatus, required this.orderCountNotifier});

  @override
  _OrderListTabState createState() => _OrderListTabState();
}

class _OrderListTabState extends State<OrderListTab> {
  late signalr.HubConnection _hubConnection;
  var checkLog = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    super.initState();
    _initializeSignalR();
  }

  void _initializeSignalR() async {
    try {
      const url = "http://ptp-srv.ddns.net:5000/hub";
      _hubConnection = signalr.HubConnectionBuilder().withUrl(url).build();
      await _hubConnection.start();

      // Subscribe to real-time events
      _hubConnection.on("messageReceived", _handleOrderUpdate);
    } catch (error) {
      checkLog.e('Error connecting to SignalR server: $error');
    }
  }

  void _handleOrderUpdate(List<Object?>? arguments) {
    // Handle real-time order update
    checkLog.d('Hub Update Orders');
    setState(() {
      // Fetch orders
      _fetchOrders().then((orders) {
        // Check if there are any orders with statuses "waiting", "preparing", or "prepared"
        bool hasAnyOrders = orders.any((order) =>
            order.status == 'Waiting' ||
            order.status == 'Preparing' ||
            order.status == 'Prepared');

        // If any such orders exist, update the order count
        if (hasAnyOrders) {
          int count = orders
              .where((order) =>
                  order.status == 'Waiting' ||
                  order.status == 'Preparing' ||
                  order.status == 'Prepared')
              .length;
          print("Set order count to: $count");
          context.read<OrderCountNotifier>().setOrderCount(count);
        } else {
          print("No orders found");
          context.read<OrderCountNotifier>().setOrderCount(
              0); // No orders matching the status, set count to 0
        }
      }).catchError((error) {
        // Handle error fetching orders
        checkLog.e('Error fetching orders: $error');
      });
    });
  }

  @override
  void dispose() {
    _hubConnection.stop();
    super.dispose();
  }

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
          List<OrderModel> filteredOrders = orders
              .where((order) => order.status == widget.orderStatus)
              .toList();
          if (filteredOrders.isEmpty) {
            return const Center(
              child: Text('Không có đơn hàng nào.'),
            );
          } else {
            return ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return OrderCardComponent(
                  order: filteredOrders[index],
                  onOrderCancelled: () {
                    // Refresh logic for parent class page
                    setState(() {});
                  },
                );
              },
            );
          }
        }
      },
    );
  }
}
