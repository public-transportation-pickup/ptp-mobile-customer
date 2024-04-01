import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  String id;
  @JsonKey(name: 'creationDate')
  String? creationDate;
  String? name;
  String? description;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  String? status;
  @JsonKey(name: 'openedTime')
  String? openedTime;
  @JsonKey(name: 'closedTime')
  String? closedTime;
  double latitude;
  double longitude;
  @JsonKey(name: 'addressNo')
  String? addressNo;
  String? street;
  String? zone;
  String? ward;
  @JsonKey(name: 'activationDate')
  String? activationDate;
  @JsonKey(name: 'imageName')
  String? imageName;
  @JsonKey(name: 'imageURL')
  String? imageURL;
  @JsonKey(name: 'userId')
  String? userId;
  String? email;
  String? password;

  StoreModel(
      {required this.id,
      this.creationDate,
      this.name,
      this.description,
      this.phoneNumber,
      this.status,
      this.openedTime,
      this.closedTime,
      required this.latitude,
      required this.longitude,
      this.addressNo,
      this.street,
      this.zone,
      this.ward,
      this.activationDate,
      this.imageName,
      this.imageURL,
      this.userId,
      this.email,
      this.password});

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
