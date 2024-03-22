import 'package:json_annotation/json_annotation.dart';
part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  final String id;
  final String? code;
  final String? stopType;
  final String? name;
  final String? status;
  final String? zone;
  final String? ward;
  final String? addressNo;
  final String? street;
  final String? supportDisability;
  final String? address;
  final double latitude;
  final double longitude;
  final int? index;

  StationModel(
      {required this.id,
      this.code,
      this.stopType,
      this.name,
      this.status,
      this.zone,
      this.ward,
      this.addressNo,
      this.street,
      this.supportDisability,
      this.address,
      required this.latitude,
      required this.longitude,
      this.index});
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
