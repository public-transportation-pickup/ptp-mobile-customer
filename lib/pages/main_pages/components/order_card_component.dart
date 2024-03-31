import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../models/order_model.dart';
import '../../../services/api_services/order_api.dart';
import '../../../utils/global_message.dart';
import '../../order_pages/order_detail_page.dart';
import 'confirm_cancel_order_card.dart';

class OrderCardComponent extends StatefulWidget {
  final OrderModel order;
  final Function()? onOrderCancelled;

  OrderCardComponent({required this.order, this.onOrderCancelled});

  @override
  _OrderCardComponentState createState() => _OrderCardComponentState();
}

class _OrderCardComponentState extends State<OrderCardComponent> {
  // Map status to corresponding icon
  final Map<String, String> statusIconMap = {
    'waiting': 'lib/assets/icons/order_wait_confirm_icon.svg',
    'preparing': 'lib/assets/icons/order_processing_icon.svg',
    'prepared': 'lib/assets/icons/order_ready_icon.svg',
  };

  // Function to get the appropriate status text based on order status
  String getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return 'Chờ xác nhận';
      case 'preparing':
        return 'Đang xử lý';
      case 'prepared':
        return 'Có thể đến lấy';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderModel order = widget.order;
    final String iconPath = statusIconMap[order.status.toLowerCase()] ?? '';
    int numberOfProducts = 0;
    // Calculate the total number of products
    for (var detail in order.orderDetails) {
      numberOfProducts += detail.quantity;
    }
    GlobalMessage globalMessage = GlobalMessage(context);

    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
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
                        const SizedBox(height: 4),
                        Text(
                          "Liên hệ cửa hàng:   ${order.storePhoneNumber}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
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
            Center(
                child: GestureDetector(
              onTap: () {
                // Navigate to OrderDetailPage and pass the order uuid
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(
                      orderUuid: order.id,
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
              child: const Text(
                'Xem thêm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                  color: Color(0xFFFCCF59),
                ),
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
                Text('$numberOfProducts sản phẩm'),
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
                if (order.status.toLowerCase() == 'waiting' ||
                    order.status.toLowerCase() == 'preparing')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        // Handle cancel button tap
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                                content: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color(0xFFFCCF59),
                                          Color.fromRGBO(255, 255, 255, 0),
                                        ],
                                        stops: [0.0126, 0.6296],
                                        transform: GradientRotation(
                                            178.52 * (3.141592653589793 / 180)),
                                      ),
                                    ),
                                    child: ConfirmCancelOrderCard(
                                      onCancel: () async {
                                        HapticFeedback.mediumImpact();
                                        // Call the function to cancel order
                                        bool cancellationSuccessful =
                                            await OrderApi.cancelOrder(
                                                order.id);
                                        Navigator.pop(context);
                                        if (cancellationSuccessful) {
                                          setState(() {});
                                          globalMessage.showSuccessMessage(
                                            "Hủy đơn thành công!",
                                          );
                                          widget.onOrderCancelled?.call();
                                        } else {
                                          globalMessage.showErrorMessage(
                                            "Hủy đơn thất bại!",
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
                      // do nothing
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
