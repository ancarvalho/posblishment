class RequestItemWithCategory {
  final String productName;
  final String categoryName;
  final String categoryId;
  final int quantity;

  RequestItemWithCategory(
      {required this.productName,
      required this.categoryName,
      required this.categoryId,
      required this.quantity});
}