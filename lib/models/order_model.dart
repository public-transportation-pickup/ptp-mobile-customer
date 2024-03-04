import 'package:json_annotation/json_annotation.dart';
import 'package:capstone_ptp/models/order_detail_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;
  String name;
  String phoneNumber;
  DateTime pickUpTime;
  double total;
  String status;
  String userId;
  String stationId;
  String stationName;
  String stationAddress;
  String storeId;
  String storeName;
  String storePhoneNumber;
  String paymentId;
  String? paymentType;
  String? paymentStatus;
  List<OrderDetailModel> orderDetails;

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
    this.paymentType,
    this.paymentStatus,
    required this.orderDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
