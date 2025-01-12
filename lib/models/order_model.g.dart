// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      pickUpTime: DateTime.parse(json['pickUpTime'] as String),
      total: json['total'] as num,
      status: json['status'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      stationId: json['stationId'] as String? ?? '',
      stationName: json['stationName'] as String? ?? '',
      stationAddress: json['stationAddress'] as String? ?? '',
      storeId: json['storeId'] as String? ?? '',
      storeName: json['storeName'] as String? ?? '',
      storeAddress: json['storeAddress'] as String? ?? '',
      storePhoneNumber: json['storePhoneNumber'] as String? ?? '',
      paymentId: json['paymentId'] as String? ?? '',
      paymentType: json['paymentType'] as String? ?? '',
      paymentStatus: json['paymentStatus'] as String? ?? '',
      orderDetails: (json['orderDetails'] as List<dynamic>?)
              ?.map((e) => OrderDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      canceledReason: json['canceledReason'] as String? ?? '',
      returnAmount: json['returnAmount'] as num? ?? 0,
      creationDate: DateTime.parse(json['creationDate'] as String),
      totalPreparationTime: json['totalPreparationTime'] as num,
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
      'storeAddress': instance.storeAddress,
      'storePhoneNumber': instance.storePhoneNumber,
      'paymentId': instance.paymentId,
      'paymentType': instance.paymentType,
      'paymentStatus': instance.paymentStatus,
      'orderDetails': instance.orderDetails,
      'canceledReason': instance.canceledReason,
      'returnAmount': instance.returnAmount,
      'creationDate': instance.creationDate,
      'totalPreparationTime': instance.totalPreparationTime,
    };
