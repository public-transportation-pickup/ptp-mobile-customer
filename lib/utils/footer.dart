import 'package:flutter/material.dart';

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
    return BottomAppBar(
      color: Color.fromARGB(255, 255, 164, 72),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.home_outlined, 'Home', 0, context),
            _buildBottomNavItem(
                Icons.notifications_none_outlined, 'Notification', 1, context),
            _buildBottomNavItem(Icons.wallet_outlined, 'Payment', 2, context),
            _buildBottomNavItem(
                Icons.inventory_2_outlined, 'Orders', 3, context),
            _buildBottomNavItem(
                Icons.account_circle_outlined, 'Profile', 4, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final color = currentIndex == index ? Colors.black : Colors.white;
    final themeData = Theme.of(context);
    final labelStyle = themeData.textTheme.caption?.copyWith(color: color);

    return InkWell(
      onTap: () {
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
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}
