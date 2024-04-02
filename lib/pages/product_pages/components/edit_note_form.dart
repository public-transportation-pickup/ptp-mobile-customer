import 'package:capstone_ptp/models/product_in_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_provider.dart';

class DialogHelper {
  static void showEditNoteDialog(
      BuildContext context, ProductInCartModel product) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController noteController =
            TextEditingController(text: product.note);
        return AlertDialog(
          title: const Text(
            'Chỉnh sửa ghi chú',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          content: TextField(
            controller: noteController,
            maxLength: 100,
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
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // Update note in provider
                Provider.of<CartProvider>(context, listen: false)
                    .updateNote(product, noteController.text);
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
