import 'package:flutter/material.dart';

import 'product_card_component.dart';

class ListProductComponent extends StatelessWidget {
  final List<Product> products;

  ListProductComponent({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (products.length / 2).ceil(),
      itemBuilder: (context, index) {
        int startIndex = index * 2;
        int endIndex = (index + 1) * 2;
        endIndex = endIndex > products.length ? products.length : endIndex;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            endIndex - startIndex,
            (i) => Expanded(
              child: ProductCard(product: products[startIndex + i]),
            ),
          ),
        );
      },
    );
  }
}
