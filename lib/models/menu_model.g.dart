// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      maxNumOrderProcess: json['maxNumOrderProcess'] as int,
      dateApply: DateTime.parse(json['dateApply'] as String),
      status: json['status'] as String,
      storeId: json['storeId'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      store: json['store'] == null
          ? null
          : StoreModel.fromJson(json['store'] as Map<String, dynamic>),
      productInMenus: (json['productInMenus'] as List<dynamic>?)
          ?.map((e) => ProductInMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'maxNumOrderProcess': instance.maxNumOrderProcess,
      'dateApply': instance.dateApply.toIso8601String(),
      'status': instance.status,
      'storeId': instance.storeId,
      'creationDate': instance.creationDate.toIso8601String(),
      'store': instance.store,
      'productInMenus': instance.productInMenus,
    };
