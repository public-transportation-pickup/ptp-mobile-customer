class ProductInCartModel {
  final String productName;
  final double actualPrice;
  final int quantity;
  final String note;
  final String productMenuId;
  final String imageURL;
  final int maxQuantity;

  ProductInCartModel({
    required this.productName,
    required this.actualPrice,
    required this.quantity,
    required this.note,
    required this.productMenuId,
    required this.imageURL,
    required this.maxQuantity,
  });
}
