import 'package:json_annotation/json_annotation.dart';
part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  final String id;
  final String code;
  final String stopType;
  final String name;
  final String status;
  final String zone;
  final String ward;
  final String addressNo;
  final String street;
  final String supportDisability;
  final String address;
  final double latitude;
  final double longitude;

  StationModel(
      {required this.id,
      required this.code,
      required this.stopType,
      required this.name,
      required this.status,
      required this.zone,
      required this.ward,
      required this.addressNo,
      required this.street,
      required this.supportDisability,
      required this.address,
      required this.latitude,
      required this.longitude});
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
