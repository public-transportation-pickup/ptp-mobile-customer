import 'package:json_annotation/json_annotation.dart';
import 'store_model.dart';
import 'product_in_menu_model.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class Menu {
  String id;
  String name;
  String description;
  String startTime;
  String endTime;
  int maxNumOrderProcess;
  DateTime dateApply;
  String status;
  String storeId;
  DateTime creationDate;
  StoreModel? store;
  List<ProductInMenu>? productInMenus;

  Menu({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.maxNumOrderProcess,
    required this.dateApply,
    required this.status,
    required this.storeId,
    required this.creationDate,
    required this.store,
    required this.productInMenus,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
