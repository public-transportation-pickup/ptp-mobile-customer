class UpdateCartRequest {
  late UpdateCartModel model;

  UpdateCartRequest({required this.model});

  Map<String, dynamic> toJson() {
    return {
      'model': model.toJson(),
    };
  }
}

class UpdateCartModel {
  late String id;
  late double total;
  late String stationId;
  late String stationAddr;
  late String phoneNumber;
  late String storeId;
  late String note;
  late String pickUpTime;
  late List<UpdateCartItem> items;

  UpdateCartModel(
      {required this.id,
      required this.total,
      required this.stationId,
      required this.stationAddr,
      required this.phoneNumber,
      required this.note,
      required this.pickUpTime,
      required this.storeId,
      required this.items});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'stationId': stationId,
      'stationAddr': stationAddr,
      'phoneNumber': phoneNumber,
      'note': note,
      'pickUpTime': pickUpTime,
      'storeId': storeId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class UpdateCartItem {
  late String productMenuId;
  late String name;
  late int quantity;
  late int maxQuantity;
  late int actualPrice;
  late String imageURL;
  late String note;

  UpdateCartItem({
    required this.productMenuId,
    required this.name,
    required this.quantity,
    required this.maxQuantity,
    required this.actualPrice,
    required this.imageURL,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'productMenuId': productMenuId,
      'name': name,
      'quantity': quantity,
      'maxQuantity': maxQuantity,
      'actualPrice': actualPrice,
      'imageURL': imageURL,
      'note': note,
    };
  }

  factory UpdateCartItem.fromJson(Map<String, dynamic> json) {
    return UpdateCartItem(
      productMenuId: json['productMenuId'],
      name: json['name'],
      quantity: json['quantity'],
      maxQuantity: json['maxQuantity'],
      actualPrice: json['actualPrice'],
      imageURL: json['imageURL'],
      note: json['note'],
    );
  }
}
