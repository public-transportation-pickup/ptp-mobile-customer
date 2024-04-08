import 'package:capstone_ptp/pages/main_pages/order_page.dart';
import 'package:capstone_ptp/utils/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../services/local_variables.dart';
import '../product_pages/cart_page.dart';
import '../product_pages/cart_provider.dart';
import 'notification_page.dart';
import 'wallet_page.dart';
import 'activity_page.dart';
import 'home_page.dart';

class PageNavigation extends StatefulWidget {
  final int initialPageIndex;

  PageNavigation({this.initialPageIndex = 0});

  @override
  _PageNavigation createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;
  late CartProvider _cartProvider;

  @override
  void initState() {
    super.initState();
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    _cartProvider.fetchCart();
    _currentIndex = widget.initialPageIndex;
    _pageController = PageController(initialPage: widget.initialPageIndex);
  }

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
            WalletPage(userId: LocalVariables.userGUID!),
            ActivityPage(),
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
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        backgroundColor: Colors.amber,
        heroTag: null,
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Stack(
              children: [
                if (cartProvider.itemCount == 0)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                      cartProvider.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    showBadge: false,
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                if (cartProvider.itemCount > 0)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                      cartProvider.itemCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
