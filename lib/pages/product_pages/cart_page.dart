import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product_in_cart_model.dart';
import 'cart_provider.dart';
import 'components/edit_note_form.dart';

class CartPage extends StatelessWidget {
  // static String name = 'Customer - ${LocalVariables.displayName} - Order';
  // static String? phoneNumber = LocalVariables.phoneNumber;
  // static DateTime pickUpTime = DateTime.now();
  // static double total = 0;
  // static String menuId = '';
  // static String stationId = '';
  // static String storeId = '';

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final List<ProductInCartModel> items = cartProvider.items;
    print("CART INFO");
    print(CartProvider.name);
    print(CartProvider.phoneNumber);
    print(CartProvider.pickUpTime);
    var test = cartProvider.calculateTotal();
    print(test);
    print(CartProvider.menuId);
    print(CartProvider.stationId);
    print(CartProvider.storeId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng của bạn'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ListView Builder for Cart Items
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(items[index].productId), // Unique key for each item
                direction:
                    DismissDirection.endToStart, // Allow right-to-left swipe
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                onDismissed: (direction) {
                  // Remove the item from the cart when dismissed
                  cartProvider.removeFromCart(items[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: items[index].imageURL.isNotEmpty
                                    ? NetworkImage(items[index].imageURL)
                                    : const AssetImage(
                                            'lib/assets/images/cafe.jpg')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Product Details (Name and Note)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].productName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Note Field
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        items[index].note,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Call the function from DialogHelper
                                        DialogHelper.showEditNoteDialog(
                                            context, items[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Price and Quantity
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatPrice(items[index].actualPrice),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              // Quantity Field with buttons
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Color(0xFFFBAB40),
                                    ),
                                    onPressed: () {
                                      if (items[index].quantity > 1) {
                                        cartProvider.updateQuantity(
                                            items[index],
                                            items[index].quantity - 1);
                                      }
                                    },
                                  ),
                                  Text(items[index].quantity.toString()),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Color(0xFFFBAB40),
                                    ),
                                    onPressed: () {
                                      cartProvider.updateQuantity(items[index],
                                          items[index].quantity + 1);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (items.isEmpty)
            const Center(
              child: Text(
                'Giỏ hàng của bạn đang trống!\nHãy thêm sản phẩm vào giỏ.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
