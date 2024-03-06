import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final PageController pageController;

  const AppFooter({
    required this.currentIndex,
    required this.onTap,
    required this.pageController,
  });

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
            _buildBottomNavItem(
                'lib/assets/icons/noti_icon.svg', 'Thông báo', 1, context),
            _buildBottomNavItem(
                'lib/assets/icons/wallet_icon.svg', 'Thanh toán', 2, context),
            _buildBottomNavItem(
                'lib/assets/icons/activity_icon.svg', 'Họat động', 3, context),
            _buildBottomNavItem(
                'lib/assets/icons/order_icon.svg', 'Đơn hàng', 4, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      String iconPath, String label, int index, BuildContext context) {
    final color = currentIndex == index
        ? const Color(0xffFCCF59)
        : Colors.black54; //Color(0xffFEEBBB);
    final themeData = Theme.of(context);
    final labelStyle = themeData.textTheme.bodySmall?.copyWith(color: color);

    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap(index);
        pageController.animateToPage(
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
            // ignore: deprecated_member_use
            color: color,
          ),
          const SizedBox(height: 4),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}
