// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      storeId: json['storeId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      phoneNumber: json['status'] as String,
      status: json['status'] as String,
      productInMenus: (json['productInMenus'] as List<dynamic>?)
          ?.map((e) => ProductInMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'name': instance.name,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'productInMenus': instance.productInMenus,
      'categories': instance.categories,
    };
