// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'] as String,
      creationDate: json['creationDate'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      phoneNumber: json['phoneNumber'] as String,
      status: json['status'] as String,
      openedTime: json['openedTime'] as String,
      closedTime: json['closedTime'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      addressNo: json['addressNo'] as String,
      street: json['street'] as String,
      zone: json['zone'] as String,
      ward: json['ward'] as String,
      activationDate: json['activationDate'] as String,
      imageName: json['imageName'] as String,
      imageURL: json['imageURL'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creationDate': instance.creationDate,
      'name': instance.name,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'openedTime': instance.openedTime,
      'closedTime': instance.closedTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'addressNo': instance.addressNo,
      'street': instance.street,
      'zone': instance.zone,
      'ward': instance.ward,
      'activationDate': instance.activationDate,
      'imageName': instance.imageName,
      'imageURL': instance.imageURL,
      'userId': instance.userId,
      'email': instance.email,
      'password': instance.password,
    };
