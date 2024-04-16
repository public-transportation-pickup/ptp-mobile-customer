import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../order_pages/order_detail_page.dart';

class OrderAgainItem {
  final String orderId;
  final String storeName;
  final String pickUpTime;

  OrderAgainItem(
      {required this.orderId,
      required this.storeName,
      required this.pickUpTime});
}

class NotifyTopicComponent extends StatefulWidget {
  final Future<List<OrderAgainItem>> orderAgainListFuture;
  final Function()? onOrderCancelled;

  NotifyTopicComponent(
      {required this.orderAgainListFuture, this.onOrderCancelled});

  @override
  _NotifyTopicComponentState createState() => _NotifyTopicComponentState();
}

class _NotifyTopicComponentState extends State<NotifyTopicComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderAgainItem>>(
      future: widget.orderAgainListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildNotificationItem(snapshot.data![index]);
            },
          );
        }
      },
    );
  }

  Widget _buildNotificationItem(OrderAgainItem item) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          // Navigate to OrderDetailPage and pass the order uuid
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailPage(
                orderUuid: item.orderId,
                refreshCallback: () {
                  // setState(() {
                  //   // Reload data
                  // });
                  widget.onOrderCancelled?.call();
                },
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFC8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'lib/assets/images/store_again.png',
                    width: double.infinity,
                    height: 85,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.storeName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF353434),
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.pickUpTime,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF353434),
                fontSize: 14,
                fontFamily: 'Montserrat',
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
