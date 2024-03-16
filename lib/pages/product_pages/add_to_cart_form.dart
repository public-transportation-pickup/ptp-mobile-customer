import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/product_in_cart_model.dart';
import '../../models/product_in_menu_model.dart';
import '../../utils/global_message.dart';

class AddToCartForm extends StatefulWidget {
  final ProductInMenu product;
  final Function(ProductInCartModel) onAddToCart;

  const AddToCartForm({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _AddToCartFormState createState() => _AddToCartFormState();
}

class _AddToCartFormState extends State<AddToCartForm> {
  String note = '';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    GlobalMessage globalMessage = GlobalMessage(context);
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Ghi chú cho cửa hàng',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Không bắt buộc',
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
              ),
              maxLines: null, // Allow multiple lines
              onChanged: (value) => note = value,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số lượng:'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity = quantity > 1 ? quantity - 1 : quantity;
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFFFBAB40),
                      ),
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Color(0xFFFBAB40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            // Create a ProductInCartModel instance
            ProductInCartModel productInCart = ProductInCartModel(
              productName: widget.product.productName,
              actualPrice: widget.product.productPrice,
              quantity: quantity,
              note: note.isEmpty ? "Không có ghi chú" : note,
              productId: widget.product.productId,
              imageURL: widget.product.imageURL,
            );

            // Call the callback function with the productInCart
            widget.onAddToCart(productInCart);
            Navigator.pop(context);
            globalMessage.showSuccessMessage("Đã thêm vào giỏ hàng!");
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFFBAB40)),
          ),
          child: const Text(
            'Xác nhận',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
