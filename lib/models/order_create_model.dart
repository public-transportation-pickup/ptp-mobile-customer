class OrderCreateModel {
  String name;
  String phoneNumber;
  String pickUpTime;
  int total;
  String stationId;
  String storeId;
  Payment payment;
  List<OrderDetailCreateModel> orderDetails;

  OrderCreateModel({
    required this.name,
    required this.phoneNumber,
    required this.pickUpTime,
    required this.total,
    required this.stationId,
    required this.storeId,
    required this.payment,
    required this.orderDetails,
  });

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) {
    return OrderCreateModel(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      pickUpTime: json['pickUpTime'] ?? '',
      total: json['total'] != null ? json['total'].toInt() : 0,
      stationId: json['stationId'] ?? '',
      storeId: json['storeId'] ?? '',
      payment: Payment.fromJson(json['payment'] ?? {}),
      orderDetails: (json['orderDetails'] as List<dynamic>? ?? [])
          .map((x) => OrderDetailCreateModel.fromJson(x ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'pickUpTime': pickUpTime,
        'total': total,
        'stationId': stationId,
        'storeId': storeId,
        'payment': payment.toJson(),
        'orderDetails': List<dynamic>.from(orderDetails.map((x) => x.toJson())),
      };
}

class Payment {
  int total;
  String paymentType;

  Payment({
    required this.total,
    required this.paymentType,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      total: json['total'],
      paymentType: json['paymentType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'paymentType': paymentType,
      };
}

class OrderDetailCreateModel {
  int actualPrice;
  int quantity;
  String note;
  String productMenuId;

  OrderDetailCreateModel({
    required this.actualPrice,
    required this.quantity,
    required this.note,
    required this.productMenuId,
  });

  factory OrderDetailCreateModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailCreateModel(
      actualPrice: json['actualPrice'],
      quantity: json['quantity'],
      note: json['note'],
      productMenuId: json['productMenuId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'actualPrice': actualPrice,
        'quantity': quantity,
        'note': note,
        'productMenuId': productMenuId,
      };
}
