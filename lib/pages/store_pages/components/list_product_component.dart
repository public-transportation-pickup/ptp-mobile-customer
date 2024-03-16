import 'package:flutter/material.dart';

import 'product_card_component.dart';

class ListProductComponent extends StatelessWidget {
  final List<Product> products;

  ListProductComponent({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        (products.length / 2).ceil(),
        (index) {
          int startIndex = index * 2;
          int endIndex = (index + 1) * 2;
          endIndex = endIndex > products.length ? products.length : endIndex;

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
                  child: ProductCard(product: products[startIndex + i]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
