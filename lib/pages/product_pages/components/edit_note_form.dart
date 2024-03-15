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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            maxLines: null, // Allow multiple lines
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update note in provider
                Provider.of<CartProvider>(context, listen: false)
                    .updateNote(product, noteController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
