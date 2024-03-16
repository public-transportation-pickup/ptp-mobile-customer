import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../models/order_create_model.dart';
import '../../models/product_in_cart_model.dart';
import '../../services/api_services/order_api.dart';
import '../../services/local_variables.dart';

class CartProvider extends ChangeNotifier {
  static var checkLog = Logger(printer: PrettyPrinter());

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

  Future<bool> createOrderAndClearCart() async {
    try {
      // Construct order details
      var initTotal = calculateTotal();
      final order = OrderCreateModel(
        name: name,
        phoneNumber: phoneNumber ?? '',
        pickUpTime: pickUpTime,
        total: initTotal,
        menuId: menuId,
        stationId: stationId,
        storeId: storeId,
        payment: Payment(total: initTotal, paymentType: 'Wallet'),
        orderDetails: items
            .map((item) => OrderDetailCreateModel(
                  actualPrice: item.actualPrice,
                  quantity: item.quantity,
                  note: item.note,
                  productMenuId: item.productId,
                ))
            .toList(),
      );

      // Call API to create order
      final createdOrder = await OrderApi.createOrder(order);

      // Clear cart items if order creation is successful
      _items.clear();
      notifyListeners();

      // Return the created order
      return createdOrder;
    } catch (e) {
      // Handle errors appropriately
      checkLog.e('Failed to call create order: $e');
      rethrow;
    }
  }
}
