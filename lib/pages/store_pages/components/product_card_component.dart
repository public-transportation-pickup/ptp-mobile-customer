import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../models/product_in_menu_model.dart';

class ProductCard extends StatelessWidget {
  final ProductInMenu product;

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return '${formattedPrice.replaceAll(',', '.')} VND';
  }

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: product.imageURL.isNotEmpty
                      ? Image.network(
                          product.imageURL,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'lib/assets/images/cafe.jpg',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Add your action here
                      },
                      heroTag: null,
                      mini: true,
                      backgroundColor: const Color(0xFFFCCF59),
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPrice(product.productPrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
