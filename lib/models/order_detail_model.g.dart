// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      id: json['id'] as String,
      actualPrice: (json['actualPrice'] as num).toDouble(),
      quantity: json['quantity'] as int,
      note: json['note'] as String,
      productMenuId: json['productMenuId'] as String,
      orderId: json['orderId'] as String,
      menuId: json['menuId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      description: json['description'] as String,
      imageURL: json['imageURL'] as String,
    );

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actualPrice': instance.actualPrice,
      'quantity': instance.quantity,
      'note': instance.note,
      'productMenuId': instance.productMenuId,
      'orderId': instance.orderId,
      'menuId': instance.menuId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'description': instance.description,
      'imageURL': instance.imageURL,
    };
