import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;

import '../pages/notification_pages/notification_model.dart';
import '../services/api_services/notification_api.dart';

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

  @override
  void initState() {
    super.initState();
    // Call the API to get the number of notifications
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationItem> notifications =
          await NotificationApi.getNotifications();
      setState(() {
        notificationCount =
            notifications.where((notification) => !notification.isSeen).length;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
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
            _buildBottomNavItem(
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
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                color: color,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  child: badges.Badge(
                    badgeContent: Text(
                      notificationCount.toString(),
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
    );
  }
}
