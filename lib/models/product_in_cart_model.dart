class ProductInCartModel {
  final String productName;
  final double actualPrice;
  final int quantity;
  final String note;
  final String productId;
  final String imageURL;

  ProductInCartModel({
    required this.productName,
    required this.actualPrice,
    required this.quantity,
    required this.note,
    required this.productId,
    required this.imageURL,
  });
}
