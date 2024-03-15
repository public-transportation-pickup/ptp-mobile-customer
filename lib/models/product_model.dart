import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  @JsonKey(name: 'preparationTime')
  final int preparationTime;
  @JsonKey(name: 'numProcessParallel')
  final int numProcessParallel;
  @JsonKey(name: 'imageName')
  final String imageName;
  @JsonKey(name: 'imageURL')
  final String imageURL;
  @JsonKey(name: 'manufacturingDate')
  final DateTime manufacturingDate;
  @JsonKey(name: 'expirationDate')
  final DateTime expirationDate;
  @JsonKey(name: 'creationDate')
  final DateTime creationDate;
  @JsonKey(name: 'storeId')
  final String storeId;
  @JsonKey(name: 'storeName')
  final String storeName;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'categoryName')
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.preparationTime,
    required this.numProcessParallel,
    required this.imageName,
    required this.imageURL,
    required this.manufacturingDate,
    required this.expirationDate,
    required this.creationDate,
    required this.storeId,
    required this.storeName,
    required this.categoryId,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
