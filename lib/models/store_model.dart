import 'package:json_annotation/json_annotation.dart';
part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  final String id;
  final String name;
  final String description;
  final String phoneNumber;
  final String status;
  final String openedTime;
  final String closedTime;
  final double latitude;
  final double longitude;
  final String street;
  final String zone;
  final String ward;
  final DateTime activationDate;
  final String imageName;
  final String imageURL;

  StoreModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.phoneNumber,
      required this.status,
      required this.openedTime,
      required this.closedTime,
      required this.latitude,
      required this.longitude,
      required this.street,
      required this.zone,
      required this.ward,
      required this.activationDate,
      required this.imageName,
      required this.imageURL});
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
  Map<String,dynamic> toJson() => _$StoreModelToJson(this);
}
