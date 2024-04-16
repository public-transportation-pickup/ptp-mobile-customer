class OrderAgainModel {
  List<Product>? products;
  List<Order>? orders;

  OrderAgainModel({this.products, this.orders});

  factory OrderAgainModel.fromJson(Map<String, dynamic> json) {
    return OrderAgainModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((x) => Product.fromJson(x))
          .toList(),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((x) => Order.fromJson(x))
          .toList(),
    );
  }
}

class Product {
  String? productMenuId;
  String? name;
  String? imageURL;
  num? actualPrice;
  int? orderCount;

  Product({
    this.productMenuId = '',
    this.name = '',
    this.imageURL = '',
    this.actualPrice = 0,
    this.orderCount = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productMenuId: json['productMenuId'] ?? '',
      name: json['name'] ?? '',
      imageURL: json['imageURL'] ?? '',
      actualPrice: json['actualPrice'] ?? 0,
      orderCount: json['orderCount'] ?? 0,
    );
  }
}

class Order {
  String? id;
  String? name;
  String? phoneNumber;
  String? pickUpTime;
  int? totalPreparationTime;
  String? canceledReason;
  num? total;
  String? status;
  String? userId;
  String? stationId;
  String? stationName;
  String? stationAddress;
  String? storeId;
  String? storeName;
  String? storeAddress;
  String? storePhoneNumber;
  String? paymentId;
  String? paymentType;
  String? creationDate;
  String? modificationDate;
  String? paymentStatus;
  dynamic returnAmount;
  List<OrderDetail>? orderDetails;

  Order({
    this.id = '',
    this.name = '',
    this.phoneNumber = '',
    this.pickUpTime = '',
    this.totalPreparationTime = 0,
    this.canceledReason = '',
    this.total = 0,
    this.status = '',
    this.userId = '',
    this.stationId = '',
    this.stationName = '',
    this.stationAddress = '',
    this.storeId = '',
    this.storeName = '',
    this.storeAddress = '',
    this.storePhoneNumber = '',
    this.paymentId = '',
    this.paymentType = '',
    this.creationDate = '',
    this.modificationDate = '',
    this.paymentStatus = '',
    this.returnAmount,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      pickUpTime: json['pickUpTime'] ?? '',
      totalPreparationTime: json['totalPreparationTime'] ?? 0,
      canceledReason: json['canceledReason'] ?? '',
      total: json['total'] ?? 0,
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      stationId: json['stationId'] ?? '',
      stationName: json['stationName'] ?? '',
      stationAddress: json['stationAddress'] ?? '',
      storeId: json['storeId'] ?? '',
      storeName: json['storeName'] ?? '',
      storeAddress: json['storeAddress'] ?? '',
      storePhoneNumber: json['storePhoneNumber'] ?? '',
      paymentId: json['paymentId'] ?? '',
      paymentType: json['paymentType'] ?? '',
      creationDate: json['creationDate'] ?? '',
      modificationDate: json['modificationDate'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      returnAmount: json['returnAmount'],
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((x) => OrderDetail.fromJson(x))
          .toList(),
    );
  }
}

class OrderDetail {
  String? id;
  num? actualPrice;
  int? quantity;
  String? note;
  String? productMenuId;
  String? orderId;
  String? menuId;
  String? productId;
  String? productName;
  num? productPrice;
  String? description;
  String? imageURL;

  OrderDetail({
    this.id = '',
    this.actualPrice = 0,
    this.quantity = 0,
    this.note = '',
    this.productMenuId = '',
    this.orderId = '',
    this.menuId = '',
    this.productId = '',
    this.productName = '',
    this.productPrice = 0,
    this.description = '',
    this.imageURL = '',
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] ?? '',
      actualPrice: json['actualPrice'] ?? 0,
      quantity: json['quantity'] ?? 0,
      note: json['note'] ?? '',
      productMenuId: json['productMenuId'] ?? '',
      orderId: json['orderId'] ?? '',
      menuId: json['menuId'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice'] ?? 0,
      description: json['description'] ?? '',
      imageURL: json['imageURL'] ?? '',
    );
  }
}
