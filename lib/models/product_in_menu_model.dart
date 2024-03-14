import 'package:json_annotation/json_annotation.dart';

part 'product_in_menu_model.g.dart';

@JsonSerializable()
class ProductInMenu {
  String id;
  String status;
  double salePrice;
  int quantityInDay;
  int quantityUsed;
  int preparationTime;
  int numProcessParallel;
  DateTime creationDate;
  String menuId;
  String menuName;
  String menuDescription;
  String productId;
  String productName;
  double productPrice;
  String productDescription;
  String imageName;
  String imageURL;
  String categoryId;
  String categoryName;
  String storeId;

  ProductInMenu({
    required this.id,
    required this.status,
    required this.salePrice,
    required this.quantityInDay,
    required this.quantityUsed,
    required this.preparationTime,
    required this.numProcessParallel,
    required this.creationDate,
    required this.menuId,
    required this.menuName,
    required this.menuDescription,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.imageName,
    required this.imageURL,
    required this.categoryId,
    required this.categoryName,
    required this.storeId,
  });

  factory ProductInMenu.fromJson(Map<String, dynamic> json) =>
      _$ProductInMenuFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInMenuToJson(this);
}
