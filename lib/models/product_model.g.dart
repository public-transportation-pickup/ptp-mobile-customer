// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      preparationTime: json['preparationTime'] as int,
      numProcessParallel: json['numProcessParallel'] as int,
      imageName: json['imageName'] as String,
      imageURL: json['imageURL'] as String,
      manufacturingDate: DateTime.parse(json['manufacturingDate'] as String),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      creationDate: DateTime.parse(json['creationDate'] as String),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'preparationTime': instance.preparationTime,
      'numProcessParallel': instance.numProcessParallel,
      'imageName': instance.imageName,
      'imageURL': instance.imageURL,
      'manufacturingDate': instance.manufacturingDate.toIso8601String(),
      'expirationDate': instance.expirationDate.toIso8601String(),
      'creationDate': instance.creationDate.toIso8601String(),
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };
