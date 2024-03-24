import 'package:json_annotation/json_annotation.dart';
import 'product_in_menu_model.dart';
import 'category_model.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class Menu {
  String storeId;
  String name;
  String description;
  String phoneNumber;
  String status;
  List<ProductInMenu>? productInMenus;
  List<CategoryModel>? categories;

  Menu({
    required this.storeId,
    required this.name,
    required this.description,
    required this.status,
    required this.phoneNumber,
    required this.categories,
    required this.productInMenus,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
