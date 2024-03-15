import 'package:flutter/material.dart';
import '../../models/product_in_cart_model.dart';

class CartProvider extends ChangeNotifier {
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
}
