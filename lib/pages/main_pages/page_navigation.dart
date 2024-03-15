import 'package:capstone_ptp/pages/main_pages/order_page.dart';
import 'package:capstone_ptp/utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_pages/cart_page.dart';
import '../product_pages/cart_provider.dart';
import 'notification_page.dart';
import 'wallet_page.dart';
import 'order_sample_page.dart';
import 'home_page.dart';

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
            OrderSamplePage(),
            OrderPage(),
          ],
        ),
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        pageController: _pageController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        heroTag: null,
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cartProvider.itemCount > 0)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartProvider.itemCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
