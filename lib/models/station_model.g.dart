// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
      id: json['id'] as String,
      code: json['code'] as String,
      stopType: json['stopType'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      zone: json['zone'] as String,
      ward: json['ward'] as String,
      addressNo: json['addressNo'] as String,
      street: json['street'] as String,
      supportDisability: json['supportDisability'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'stopType': instance.stopType,
      'name': instance.name,
      'status': instance.status,
      'zone': instance.zone,
      'ward': instance.ward,
      'addressNo': instance.addressNo,
      'street': instance.street,
      'supportDisability': instance.supportDisability,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
