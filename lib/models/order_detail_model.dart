import 'package:json_annotation/json_annotation.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
  String id;
  double actualPrice;
  int quantity;
  String note;
  String productMenuId;
  String orderId;
  String menuId;
  String productId;
  String? productName;
  double productPrice;
  String? description;
  String? imageURL;

  OrderDetailModel({
    required this.id,
    required this.actualPrice,
    required this.quantity,
    required this.note,
    required this.productMenuId,
    required this.orderId,
    required this.menuId,
    required this.productId,
    this.productName,
    required this.productPrice,
    this.description,
    this.imageURL,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
