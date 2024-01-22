import 'package:capstone_ptp/utils/footer.dart';
import 'package:flutter/material.dart';

import 'notification_page.dart';
import 'wallet_page.dart';
import 'order_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class PageNavigation extends StatefulWidget {
  @override
  _PageNavigation createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _navigateToPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false, // Disable the swipe back gesture
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            HomePage(),
            NotificationPage(),
            WalletPage(),
            OrderPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        pageController: _pageController,
      ),
    );
  }
}
