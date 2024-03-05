import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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

  // Function to get the appropriate status text based on order status
  String getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'created':
        return 'Chờ xác nhận';
      case 'processing':
        return 'Đang xử lý';
      case 'completed':
        return 'Có thể đến lấy';
      default:
        return status; // Default to the original status if not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    final String iconPath = statusIconMap[order.status.toLowerCase()] ?? '';
    int numberOfProducts = 0;
    // Calculate the total number of products
    for (var detail in order.orderDetails) {
      numberOfProducts += detail.quantity;
    }

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
                  height: 64,
                  width: 64,
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
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/bus_stop_icon.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Trạm đến:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${order.stationName} - ${order.stationAddress}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/clock_get_product_icon.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Thời gian có thể đến lấy hàng:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('HH:mm dd/MM/yyyy').format(order.pickUpTime),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
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
                Expanded(
                  child: Text(
                    order.orderDetails.isNotEmpty
                        ? order.orderDetails[0].productName
                        : 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        order.orderDetails.isNotEmpty
                            ? 'x${order.orderDetails[0].quantity.toString()}'
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: Color(0xFFFCCF59),
                        ),
                      ),
                      //NumberFormat('#,###', 'vi_VN').format(order.orderDetails[0].actualPrice.toInt())
                      Text(
                        order.orderDetails.isNotEmpty
                            ? NumberFormat('#,###', 'vi_VN').format(order
                                .orderDetails[0].actualPrice
                                .toInt()) //order.orderDetails[0].actualPrice.toString()
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
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
                Text('${numberOfProducts} sản phẩm'),
                RichText(
                  text: TextSpan(
                    text:
                        'Tổng cộng:    ${NumberFormat('#,###', 'vi_VN').format(order.total.toInt())}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'đ',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            //===================================
            //Handle logic for button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Check if the order status is 'created' to show the second button
                if (order.status.toLowerCase() == 'created')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle View More button tap
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text(
                        'Hủy đơn',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                            color: Colors.white),
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
                      getOrderStatusText(order.status),
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
