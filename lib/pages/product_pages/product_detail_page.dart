import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../models/product_model.dart';
import '../../services/api_services/product_api.dart';
import 'add_to_cart_form.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Product> _productFuture;

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  void initState() {
    super.initState();
    _productFuture = ProductApi.getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
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

  Widget _buildProductDetail(Product product) {
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
        // Product Name & price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.name,
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
                formatPrice(product.price),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        // Product Description
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.description.isNotEmpty ? product.description : 'N/A',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
              color: Colors.grey,
            ),
          ),
        ),

        const SizedBox(height: 8),
        // Product Description
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            product.preparationTime.toString().isNotEmpty
                ? product.preparationTime.toString()
                : 'N/A',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
              color: Colors.grey,
            ),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddToCartForm(
                    onAddToCart: (String note, int quantity) {
                      // Here you can implement logic to add the product to the cart
                      // For example, you can use a function from your product service
                      // or manage the cart state within this widget or its parent widget.
                      print(
                          'Added to cart: $quantity ${widget.productId}(s) with note: $note');
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
