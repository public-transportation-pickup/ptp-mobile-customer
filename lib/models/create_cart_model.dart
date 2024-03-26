import 'cart_model.dart';

class CreateCartRequest {
  late CreateCartModel model;

  CreateCartRequest({required this.model});

  Map<String, dynamic> toJson() {
    return {
      'model': model.toJson(),
    };
  }
}

class CreateCartModel {
  late String stationId;
  late String phoneNumber;
  late String note;
  late String pickUpTime;
  late int total;
  late List<CartItem> items;

  CreateCartModel(
      {required this.stationId,
      required this.phoneNumber,
      required this.note,
      required this.pickUpTime,
      required this.total,
      required this.items});

  Map<String, dynamic> toJson() {
    return {
      'stationId': stationId,
      'phoneNumber': phoneNumber,
      'note': note,
      'pickUpTime': pickUpTime,
      'total': total,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
