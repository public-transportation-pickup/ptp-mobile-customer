import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductAgainItem {
  final String productName;
  final String imageUrl;
  final num price;

  ProductAgainItem(
      {required this.productName, required this.imageUrl, required this.price});
}

class CustomCarouselSlider extends StatefulWidget {
  final Future<List<ProductAgainItem>> productAgainListFuture;

  CustomCarouselSlider({required this.productAgainListFuture});

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductAgainItem>>(
      future: widget.productAgainListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<ProductAgainItem> productList = snapshot.data!;
        return SizedBox(
          height: 170,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {});
              },
              viewportFraction: 0.33,
            ),
            items: productList.length == 1
                ? [_buildProductItem(productList.first)]
                : productList.take(5).map((product) {
                    return _buildProductItem(product);
                  }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildProductItem(ProductAgainItem product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              product.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.productName,
            style: const TextStyle(
              color: Color(0xFF353434),
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${product.price.toInt()}',
            style: const TextStyle(
              color: Color(0xFF353434),
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
