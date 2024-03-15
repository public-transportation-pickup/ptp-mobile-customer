import 'package:flutter/material.dart';

class AddToCartForm extends StatefulWidget {
  final Function(String note, int quantity) onAddToCart;

  const AddToCartForm({
    Key? key,
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
    return AlertDialog(
      // title: const Text(
      //   'Thêm vào giỏ hàng',
      //   style: TextStyle(color: Color(0xFFFBAB40)),
      // ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ghi chú cho cửa hàng',
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                hintText: 'Không bắt buộc',
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
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
            // Call the callback function with the note and quantity
            widget.onAddToCart(note, quantity);
            Navigator.pop(context);
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
