import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/order_model.dart';

class OrderCardComponent extends StatelessWidget {
  final OrderModel order;

  OrderCardComponent({required this.order});

  // Map status to corresponding icon
  final Map<String, String> statusIconMap = {
    'created': 'lib/assets/icons/order_wait_confirm_icon.svg',
    'processing': 'lib/assets/icons/order_processing_icon.svg',
    'completed': 'lib/assets/icons/order_ready_icon.svg',
  };

  @override
  Widget build(BuildContext context) {
    final String iconPath = statusIconMap[order.status.toLowerCase()] ?? '';
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 74,
                  width: 74,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    order.storeName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            //================================================================
            const SizedBox(height: 8),
            Text(
              'Name: ${order.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Pick Up Time: ${order.pickUpTime}'),
            const SizedBox(height: 8),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            //================================================================
            const SizedBox(height: 8),
            const Center(
                child: Text(
              'Xem thêm',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
                color: Color(0xFFFCCF59),
              ),
            )),
            const SizedBox(height: 8),
            const Divider(
              height: 2,
              color: Colors.black12,
            ),
            //================================================================
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Type: ${order.paymentType ?? 'N/A'}'),
                Text('Total: \$${order.total.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle View More button tap
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle View More button tap
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFBAB40)),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
