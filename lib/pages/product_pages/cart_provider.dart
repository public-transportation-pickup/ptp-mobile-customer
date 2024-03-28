import 'package:capstone_ptp/models/cart_model.dart';
import 'package:capstone_ptp/models/create_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../models/order_create_model.dart';
import '../../models/product_in_cart_model.dart';
import '../../models/update_cart_model.dart';
import '../../services/api_services/order_api.dart';
import '../../services/api_services/cart_api.dart';
import '../../services/local_variables.dart';

class CartProvider extends ChangeNotifier {
  static var checkLog = Logger(printer: PrettyPrinter());

  static String name = 'Customer - ${LocalVariables.displayName} - Order';
  static String? phoneNumber = LocalVariables.phoneNumber;
  static DateTime pickUpTime = DateTime.now();
  static String arrivalTime = '';
  static String stationId = '';
  //static String storeId = '4504b5b5-2a3f-4815-a768-d166faabd33d';
  static String storeId = '';
  static String cartIdMongo = '';

  final List<ProductInCartModel> _items = [];

  CartProvider() {
    // Fetch cart automatically when CartProvider is initialized
    _fetchCart();
  }

  List<ProductInCartModel> get items => _items;

  int get itemCount => _items.length;

  void addToCart(ProductInCartModel newItem) {
    // Check if the item already exists in the cart
    for (var existingItem in _items) {
      if (existingItem.productId == newItem.productId) {
        // If the item already exists, update the quantity and notify listeners
        updateQuantity(existingItem, existingItem.quantity + newItem.quantity);
        return;
      }
    }
    // If the item doesn't exist, add it to the cart
    _items.add(newItem);
    notifyListeners();
  }

  Future<void> _fetchCart() async {
    if (_items.isEmpty) {
      await fetchCart();
    } else {
      // do nothing
    }
  }

  // Method to fetch the user's cart from the API
  Future<List<ProductInCartModel>> fetchCart() async {
    try {
      Cart? cart = await CartApi.fetchCart();
      if (cart != null) {
        cartIdMongo = cart.id;
        stationId = cart.stationId;
        storeId = cart.storeId;
        _items.clear(); // Clear existing items
        for (var item in cart.items) {
          _items.add(ProductInCartModel(
            productName: item.name,
            actualPrice: item.actualPrice.toDouble(),
            quantity: item.quantity,
            imageURL: item.imageURL,
            note: item.note,
            productId: item.productMenuId,
          ));
        }
        // Notify listeners about the changes
        notifyListeners();
        return _items; // Return the fetched cart items
      } else {
        // If the cart is empty, return an empty list of items
        _items.clear();
        notifyListeners();
        return _items;
      }
    } catch (e) {
      // Handle errors appropriately
      checkLog.e('Failed to fetch cart: $e');
      // If an error occurred, set local cart to empty and return an empty list
      _items.clear();
      notifyListeners();
      return _items;
    }
  }

  // Call API to create cart if fetch cart empty
  Future<bool> createCart() async {
    try {
      final cart = CreateCartModel(
        stationId: stationId,
        phoneNumber: phoneNumber ?? '',
        pickUpTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .format(pickUpTime.toUtc()),
        storeId: storeId,
        note: '',
        items: items
            .map((item) => CreateCartItem(
                  productMenuId: item.productId,
                  name: item.productName,
                  quantity: item.quantity,
                  actualPrice: item.actualPrice.toInt(),
                  imageURL: item.imageURL,
                  note: item.note,
                ))
            .toList(),
      );

      // Call API to create cart
      final createdCart = await CartApi.createCart(cart);

      _fetchCart();
      Cart? tmpCart = await CartApi.fetchCart();
      if (tmpCart != null) {
        cartIdMongo = tmpCart.id;
      } else {
        cartIdMongo = '';
      }
      notifyListeners();

      // Return the created order
      return createdCart;
    } catch (e) {
      // Handle errors appropriately
      checkLog.e('Failed to call create cart: $e');
      rethrow;
    }
  }

  // Call API to update cart if fetch cart empty
  Future<bool> updateCart() async {
    try {
      final cart = UpdateCartModel(
        id: cartIdMongo,
        total: 0,
        stationId: stationId,
        phoneNumber: phoneNumber ?? '',
        pickUpTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .format(pickUpTime.toUtc()),
        storeId: storeId,
        note: '',
        items: items
            .map((item) => UpdateCartItem(
                  productMenuId: item.productId,
                  name: item.productName,
                  quantity: item.quantity,
                  actualPrice: item.actualPrice.toInt(),
                  imageURL: item.imageURL,
                  note: item.note,
                ))
            .toList(),
      );

      // Call API to create cart
      final updatedCart = await CartApi.updateCart(cart);

      _fetchCart();
      notifyListeners();

      // Return the created order
      return updatedCart;
    } catch (e) {
      // Handle errors appropriately
      checkLog.e('Failed to call update cart: $e');
      rethrow;
    }
  }

  void saveCart() async {
    var checkFetchCart = await CartApi.fetchCart();
    if (_items.isNotEmpty && checkFetchCart == null) {
      checkLog.d("Call api create cart");
      createCart();
    }
    if (_items.isNotEmpty && checkFetchCart != null) {
      checkLog.d("Call api update cart");
      updateCart();
    }
    notifyListeners();
  }

  void removeFromCart(ProductInCartModel item) async {
    _items.remove(item);
    if (_items.isEmpty) {
      await CartApi.deleteCart();
      checkLog.d("Cart list is empty, call delete cart api success");
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    name = '';
    phoneNumber = '';
    pickUpTime = DateTime.now();
    arrivalTime = '';
    stationId = '';
    storeId = '';
    cartIdMongo = '';
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
        menuId: '',
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
