import 'package:capstone_ptp/utils/order_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../models/order_model.dart';
import '../pages/notification_pages/notification_model.dart';
import '../services/api_services/notification_api.dart';
import '../services/api_services/order_api.dart';
import 'noti_count.dart';

class AppFooter extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final PageController pageController;

  const AppFooter({
    required this.currentIndex,
    required this.onTap,
    required this.pageController,
  });

  @override
  _AppFooterState createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  int notificationCount = 0;
  int orderCount = 0;
  late NotificationCountNotifier _notifier;
  late OrderCountNotifier _orderNotifier;

  @override
  void initState() {
    super.initState();
    // Call the API to get the number of notifications
    _fetchNotifications();
    _fetchOrders();
    _notifier = context.read<NotificationCountNotifier>();
    _orderNotifier = context.read<OrderCountNotifier>();
    // Listen to changes in OrderCountNotifier
    _orderNotifier.addListener(_onOrderCountChange);
  }

  void _onOrderCountChange() {
    setState(() {
      orderCount = _orderNotifier.orderCount;
    });
  }

  @override
  void dispose() {
    _orderNotifier.removeListener(_onOrderCountChange);
    super.dispose();
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationItem> notifications =
          await NotificationApi.getNotifications();
      int newNotificationCount =
          notifications.where((notification) => !notification.isSeen).length;

      // Update the notification count using the notifier
      _notifier.setNotificationCount(newNotificationCount);

      setState(() {
        notificationCount = newNotificationCount;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  Future<void> _fetchOrders() async {
    try {
      List<OrderModel> allOrders = await OrderApi.getOrdersOfUser();
      List<OrderModel> filteredOrders = allOrders
          .where((order) =>
              order.status == "Preparing" ||
              order.status == "Waiting" ||
              order.status == "Prepared")
          .toList();

      int orderLength = filteredOrders.length;
      // Update the notification count using the notifier
      _orderNotifier.setOrderCount(orderLength);
      setState(() {
        orderCount = orderLength;
      });
    } catch (error) {
      print('Error fetching orders: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
                'lib/assets/icons/home_icon.svg', 'Trang chủ', 0, context),
            _buildNotificationItem(
                'lib/assets/icons/noti_icon.svg', 'Thông báo', 1, context),
            _buildBottomNavItem(
                'lib/assets/icons/wallet_icon.svg', 'Ví của tôi', 2, context),
            _buildBottomNavItem(
                'lib/assets/icons/activity_icon.svg', 'Hoạt động', 3, context),
            _buildOrderItem(
                'lib/assets/icons/order_icon.svg', 'Đơn hàng', 4, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      String iconPath, String label, int index, BuildContext context) {
    final color = widget.currentIndex == index
        ? const Color(0xffFCCF59)
        : Colors.black54; //Color(0xffFEEBBB);
    final themeData = Theme.of(context);
    final labelStyle = themeData.textTheme.bodySmall?.copyWith(color: color);

    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap(index);
        widget.pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceIn,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      String iconPath, String label, int index, BuildContext context) {
    final color = widget.currentIndex == index
        ? const Color(0xffFCCF59)
        : Colors.black54; //Color(0xffFEEBBB);
    final themeData = Theme.of(context);
    final labelStyle = themeData.textTheme.bodySmall?.copyWith(color: color);

    return Consumer<NotificationCountNotifier>(
      builder: (context, notifier, _) => InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          widget.onTap(index);
          widget.pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: color,
                ),
                if (notifier.notificationCount > 0)
                  Positioned(
                    right: 0,
                    child: badges.Badge(
                      badgeContent: Text(
                        notifier.notificationCount.toString(),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      child: Container(
                        width: 16,
                        height: 16,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(
      String iconPath, String label, int index, BuildContext context) {
    final color = widget.currentIndex == index
        ? const Color(0xffFCCF59)
        : Colors.black54; //Color(0xffFEEBBB);
    final themeData = Theme.of(context);
    final labelStyle = themeData.textTheme.bodySmall?.copyWith(color: color);

    return Consumer<OrderCountNotifier>(
      builder: (context, notifier, _) => InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          widget.onTap(index);
          widget.pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: color,
                ),
                if (notifier.orderCount > 0)
                  Positioned(
                    right: 0,
                    child: badges.Badge(
                      badgeContent: Text(
                        notifier.orderCount.toString(),
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      child: Container(
                        width: 16,
                        height: 16,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}
