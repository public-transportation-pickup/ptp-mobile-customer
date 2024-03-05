import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../models/order_model.dart';
import '../../services/api_services/order_api.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderUuid;

  OrderDetailPage({required this.orderUuid});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<OrderModel> _orderDetails;

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
        return status;
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the API to get order details using the orderUuid
    _orderDetails = OrderApi.getOrderDetails(widget.orderUuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
        centerTitle: true,
      ),
      body: FutureBuilder<OrderModel>(
        future: _orderDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the API response
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return const Center(child: Text('Có lỗi xảy ra vui lòng thử lại!'));
          } else {
            // Display the order details once fetched
            return Column(
              children: [
                buildOrderDetails(snapshot.data!),
                const SizedBox(height: 8),
                if (snapshot.data?.status.toLowerCase() == 'created')
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle cancel button tap
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
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildOrderDetails(OrderModel order) {
    final String iconPath = statusIconMap[order.status.toLowerCase()] ?? '';
    int numberOfProducts = 0;
    // Calculate the total number of products
    for (var detail in order.orderDetails) {
      numberOfProducts += detail.quantity;
    }
    // Build the UI for displaying order details
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              // List product of order
              const SizedBox(height: 16),
              const Text(
                'Đơn hàng',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.orderDetails.length,
                itemBuilder: (context, index) {
                  final orderDetail = order.orderDetails[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Image.asset(
                              'lib/assets/images/cafe.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  orderDetail.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                if (orderDetail.note.isNotEmpty)
                                  const SizedBox(height: 4),
                                Text(
                                  orderDetail.note,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'x${orderDetail.quantity.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                                color: Color(0xFFFCCF59),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 4,
                            child: Text(
                              NumberFormat('#,###', 'vi_VN')
                                  .format(orderDetail.actualPrice.toInt()),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        height: 2,
                        color: Colors.black12,
                      ),
                    ],
                  );
                },
              ),

              //================================================================
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '*Lấy hàng tại cửa hàng',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                  Text('$numberOfProducts sản phẩm'),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 2,
                color: Colors.black12,
              ),
              //================================================================
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trạng thái: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    getOrderStatusText(order.status),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Color(0xFFFCCF59),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 2,
                color: Colors.black12,
              ),
              //================================================================
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:
                          '${NumberFormat('#,###', 'vi_VN').format(order.total.toInt())}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'đ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
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
            ],
          ),
        ),
      ),
    );
  }
}
