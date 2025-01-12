import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/menu_model.dart';
import 'package:capstone_ptp/services/api_services/store_api.dart';
import 'package:intl/intl.dart';

import '../../../models/category_model.dart';
import '../../../models/product_in_menu_model.dart';
import '../../product_pages/cart_provider.dart';
import 'product_card_component.dart';

class ListProductComponent extends StatefulWidget {
  final String storeId;
  final String arrivalTime;
  final DateTime now;
  final Function(List<CategoryModel>?) updateCategories;
  final Function(List<ProductInMenu>?) updateProductsInMenu;

  ListProductComponent({
    required this.storeId,
    required this.arrivalTime,
    required this.now,
    required this.updateCategories,
    required this.updateProductsInMenu,
  });

  @override
  _ListProductComponentState createState() => _ListProductComponentState();
}

class _ListProductComponentState extends State<ListProductComponent> {
  late Future<Menu> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = _fetchMenu();
  }

  Future<Menu> _fetchMenu() async {
    try {
      Menu menu = await StoreApi.getProductsInMenuOfStore(
        widget.storeId,
        widget.arrivalTime,
        widget.now.toString(),
      );

      // Call updateCategories only once when data is fetched
      widget.updateCategories(menu.categories);
      widget.updateProductsInMenu(menu.productInMenus);

      // Update CartProvider
      // CartProvider.storeId = widget.storeId;
      DateTime current = DateTime.now();
      DateTime formatedTime = DateTime(
          current.year,
          current.month,
          current.day,
          DateFormat('HH:mm').parse(widget.arrivalTime).hour,
          DateFormat('HH:mm').parse(widget.arrivalTime).minute);
      DateTime pickUpDateTime = formatedTime.add(const Duration(hours: 1));
      CartProvider.pickUpTime = pickUpDateTime;

      return menu;
    } catch (e) {
      throw Exception('Failed to fetch menu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _menuFuture,
      builder: (context, AsyncSnapshot<Menu> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Có lỗi xảy ra vui lòng thử lại: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data!.productInMenus!.isEmpty) {
          return const Center(
            child: Text(
              'Cửa hàng hiện tại đã đóng cửa.\nHoặc không cung cấp thực đơn trong thời điểm hiện tại.\nVui lòng quay lại sau!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          Menu menu = snapshot.data!;
          return Column(
            children: List.generate(
              (menu.productInMenus!.length / 2).ceil(),
              (index) {
                int startIndex = index * 2;
                int endIndex = (index + 1) * 2;
                endIndex = endIndex > menu.productInMenus!.length
                    ? menu.productInMenus!.length
                    : endIndex;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    endIndex - startIndex,
                    (i) {
                      int totalProducts = endIndex - startIndex;
                      double itemWidth = totalProducts == 1
                          ? MediaQuery.of(context).size.width * 0.9
                          : MediaQuery.of(context).size.width * 0.43;

                      return SizedBox(
                        width: itemWidth,
                        child: ProductCard(
                            product: menu.productInMenus![startIndex + i]),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
