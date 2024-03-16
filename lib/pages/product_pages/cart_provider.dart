import 'package:flutter/material.dart';
import '../../models/product_in_cart_model.dart';
import '../../services/local_variables.dart';

class CartProvider extends ChangeNotifier {
  static String name = 'Customer - ${LocalVariables.displayName} - Order';
  static String? phoneNumber = LocalVariables.phoneNumber;
  static DateTime pickUpTime = DateTime.now();
  static String arrivalTime = '';
  static String menuId = '';
  static String stationId = '';
  static String storeId = '';

  final List<ProductInCartModel> _items = [];

  CartProvider();

  List<ProductInCartModel> get items => _items;

  int get itemCount => _items.length;

  void addToCart(ProductInCartModel item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(ProductInCartModel item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(ProductInCartModel item, int newQuantity) {
    final index = _items.indexOf(item);
    if (index != -1) {
      // Create a new instance of ProductInCartModel with updated quantity
      final updatedItem = ProductInCartModel(
        productName: item.productName,
        actualPrice: item.actualPrice,
        quantity: newQuantity,
        imageURL: item.imageURL,
        note: item.note,
        productId: item.productId,
      );
      // Replace the item in the list with the updated one
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  void updateNote(ProductInCartModel item, String newNote) {
    final index = _items.indexOf(item);
    if (index != -1) {
      final updatedItem = ProductInCartModel(
        productName: item.productName,
        actualPrice: item.actualPrice,
        quantity: item.quantity,
        imageURL: item.imageURL,
        note: newNote,
        productId: item.productId,
      );
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  double calculateTotal() {
    double totalPrice = 0;
    for (var item in _items) {
      totalPrice += item.actualPrice * item.quantity;
    }
    return totalPrice;
  }
}
