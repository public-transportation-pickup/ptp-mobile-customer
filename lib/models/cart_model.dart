class Cart {
  late String id;
  late String note;
  late String stationId;
  late String storeId;
  late String userId;
  late bool isCurrent;
  late List<CartItem> items;

  Cart(
      {required this.id,
      required this.note,
      required this.stationId,
      required this.storeId,
      required this.userId,
      required this.isCurrent,
      required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      note: json['note'],
      stationId: json['stationId'],
      storeId: json['storeId'],
      userId: json['userId'],
      isCurrent: json['isCurrent'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}

class CartItem {
  late String? id;
  late String productMenuId;
  late String name;
  late int quantity;
  late int actualPrice;
  late String imageURL;
  late String note;

  CartItem({
    this.id,
    required this.productMenuId,
    required this.name,
    required this.quantity,
    required this.actualPrice,
    required this.imageURL,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productMenuId': productMenuId,
      'name': name,
      'quantity': quantity,
      'actualPrice': actualPrice,
      'imageURL': imageURL,
      'note': note,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productMenuId: json['productMenuId'],
      name: json['name'],
      quantity: json['quantity'],
      actualPrice: json['actualPrice'],
      imageURL: json['imageURL'],
      note: json['note'],
    );
  }
}
