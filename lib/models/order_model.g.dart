// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      pickUpTime: DateTime.parse(json['pickUpTime'] as String),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      userId: json['userId'] as String,
      stationId: json['stationId'] as String,
      stationName: json['stationName'] as String,
      stationAddress: json['stationAddress'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      storePhoneNumber: json['storePhoneNumber'] as String,
      paymentId: json['paymentId'] as String,
      paymentType: json['paymentType'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'pickUpTime': instance.pickUpTime.toIso8601String(),
      'total': instance.total,
      'status': instance.status,
      'userId': instance.userId,
      'stationId': instance.stationId,
      'stationName': instance.stationName,
      'stationAddress': instance.stationAddress,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'storePhoneNumber': instance.storePhoneNumber,
      'paymentId': instance.paymentId,
      'paymentType': instance.paymentType,
      'paymentStatus': instance.paymentStatus,
    };
