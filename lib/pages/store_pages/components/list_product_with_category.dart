import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/product_in_menu_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ProductWithCategoryCard extends StatelessWidget {
  final ProductInMenu product;
  final VoidCallback onPressed;

  const ProductWithCategoryCard({
    required this.product,
    required this.onPressed,
  });

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                ),

                const SizedBox(width: 10),

                // Product Details and Add Button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Product description
                      Text(
                        product.productDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Product Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            formatPrice(product.salePrice),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatPrice(product.productPrice),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            'lib/assets/icons/baseline_discount_icon.svg',
                            width: 14,
                            height: 14,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipOval(
                            child: Material(
                              color: const Color(0xFFFCCF59),
                              child: InkWell(
                                onTap: onPressed,
                                child: const SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
