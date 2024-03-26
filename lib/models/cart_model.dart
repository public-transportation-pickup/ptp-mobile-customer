class Cart {
  late String id;
  late String note;
  late String stationId;
  late String userId;
  late bool isCurrent;
  late List<CartItem> items;

  Cart(
      {required this.id,
      required this.note,
      required this.stationId,
      required this.userId,
      required this.isCurrent,
      required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      note: json['note'],
      stationId: json['stationId'],
      userId: json['userId'],
      isCurrent: json['isCurrent'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class CartItem {
  late String id;
  late String productMenuId;
  late int quantity;
  late int actualPrice;
  late String note;

  CartItem({
    required this.id,
    required this.productMenuId,
    required this.quantity,
    required this.actualPrice,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productMenuId': productMenuId,
      'quantity': quantity,
      'actualPrice': actualPrice,
      'note': note,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productMenuId: json['productMenuId'],
      quantity: json['quantity'],
      actualPrice: json['actualPrice'],
      note: json['note'],
    );
  }
}
