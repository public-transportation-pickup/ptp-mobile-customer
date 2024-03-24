import 'package:json_annotation/json_annotation.dart';
import 'order_detail_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime pickUpTime;
  final num totalPreparationTime;
  final String? canceledReason;
  final num total;
  final String status;
  final String userId;
  final String stationId;
  final String stationName;
  final String stationAddress;
  final String storeId;
  final String storeName;
  final String storePhoneNumber;
  final String paymentId;
  final String paymentType;
  final String paymentStatus;
  final DateTime creationDate;
  final num? returnAmount;
  final List<OrderDetailModel> orderDetails;

  OrderModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.pickUpTime,
    required this.total,
    required this.status,
    required this.userId,
    required this.stationId,
    required this.stationName,
    required this.stationAddress,
    required this.storeId,
    required this.storeName,
    required this.storePhoneNumber,
    required this.paymentId,
    required this.paymentType,
    required this.paymentStatus,
    required this.orderDetails,
    required this.totalPreparationTime,
    required this.creationDate,
    this.canceledReason,
    this.returnAmount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
