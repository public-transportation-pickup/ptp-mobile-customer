// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_in_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInMenu _$ProductInMenuFromJson(Map<String, dynamic> json) =>
    ProductInMenu(
      id: json['id'] as String,
      status: json['status'] as String,
      salePrice: (json['salePrice'] as num).toDouble(),
      quantityInDay: json['quantityInDay'] as int,
      quantityUsed: json['quantityUsed'] as int,
      preparationTime: json['preparationTime'] as int,
      numProcessParallel: json['numProcessParallel'] as int,
      creationDate: DateTime.parse(json['creationDate'] as String),
      menuId: json['menuId'] as String,
      menuName: json['menuName'] as String,
      menuDescription: json['menuDescription'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productDescription: json['productDescription'] as String,
      imageName: json['imageName'] as String,
      imageURL: json['imageURL'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      storeId: json['storeId'] as String,
    );

Map<String, dynamic> _$ProductInMenuToJson(ProductInMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'salePrice': instance.salePrice,
      'quantityInDay': instance.quantityInDay,
      'quantityUsed': instance.quantityUsed,
      'preparationTime': instance.preparationTime,
      'numProcessParallel': instance.numProcessParallel,
      'creationDate': instance.creationDate.toIso8601String(),
      'menuId': instance.menuId,
      'menuName': instance.menuName,
      'menuDescription': instance.menuDescription,
      'productId': instance.productId,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
      'imageName': instance.imageName,
      'imageURL': instance.imageURL,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'storeId': instance.storeId,
    };
