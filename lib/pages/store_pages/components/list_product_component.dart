import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/menu_model.dart';
import 'package:capstone_ptp/services/api_services/store_api.dart';
import 'package:intl/intl.dart';

import '../../product_pages/cart_provider.dart';
import 'product_card_component.dart';

class ListProductComponent extends StatelessWidget {
  final String storeId;
  final String arrivalTime;
  final DateTime now;

  ListProductComponent({
    required this.storeId,
    required this.arrivalTime,
    required this.now,
  });

  Future<Menu> _fetchMenu() async {
    try {
      Menu menu = await StoreApi.getProductsInMenuOfStore(
        storeId,
        arrivalTime,
        now.toString(),
      );

      CartProvider.storeId = storeId;
      DateTime current = DateTime.now();
      DateTime formatedTime = DateTime(
          current.year,
          current.month,
          current.day,
          DateFormat('HH:mm').parse(arrivalTime).hour,
          DateFormat('HH:mm').parse(arrivalTime).minute);
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
      future: _fetchMenu(),
      builder: (context, AsyncSnapshot<Menu> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
