import 'package:json_annotation/json_annotation.dart';

part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel {
  final String id;
  final double actualPrice;
  final int quantity;
  final String note;
  final String productMenuId;
  final String orderId;
  final String menuId;
  final String productId;
  final String productName;
  final double productPrice;
  final String description;
  final String imageURL;

  OrderDetailModel({
    required this.id,
    required this.actualPrice,
    required this.quantity,
    required this.note,
    required this.productMenuId,
    required this.orderId,
    required this.menuId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.imageURL,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
