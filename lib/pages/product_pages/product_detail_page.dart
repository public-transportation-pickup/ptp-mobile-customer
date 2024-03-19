import 'package:capstone_ptp/models/product_in_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/product_in_cart_model.dart';
import '../../services/api_services/product_api.dart';
import 'add_to_cart_form.dart';
import 'cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<ProductInMenu> _productFuture;

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  void initState() {
    super.initState();
    _productFuture = ProductApi.getProductInMenuById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ProductInMenu>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return _buildProductDetail(snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductDetail(ProductInMenu product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        SizedBox(
          width: double.infinity,
          height: 200,
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
        const SizedBox(height: 16),
        // Product Name & sale price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                formatPrice(product.salePrice),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
        // Product price
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                formatPrice(product.productPrice),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        // Product Description
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.productDescription.isNotEmpty
                ? product.productDescription
                : 'N/A',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
              color: Colors.grey,
            ),
          ),
        ),

        const SizedBox(height: 8),
        // Product Preparing Time
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                product.preparationTime.toString().isNotEmpty
                    ? 'Thời gian chuẩn bị món:  ${product.preparationTime} phút'
                    : 'Thời gian chuẩn bị món:  N/A',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        // Product quantity in day
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.production_quantity_limits,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                product.preparationTime.toString().isNotEmpty
                    ? 'Số lượng còn lại: ${product.quantityInDay - product.quantityUsed}'
                    : 'Số lượng còn lại: N/A',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // Divider
        const SizedBox(height: 8),
        const Divider(
          color: Color.fromARGB(255, 214, 214, 214),
          thickness: 5,
          height: 16.0,
        ),
        const SizedBox(height: 8),

        // Add to cart button
        Center(
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FutureBuilder<ProductInMenu>(
                    future: _productFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return AddToCartForm(
                          product: snapshot.data!,
                          onAddToCart: (ProductInCartModel productInCart) {
                            // Here you can add the productInCart to the cart
                            // using CartProvider
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(productInCart);
                            // Set Value cart
                            CartProvider.menuId = product.menuId;
                          },
                        );
                      }
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFBAB40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Thêm vào giỏ hàng',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
