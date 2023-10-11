class RequestItem {
  final String id;
  final String name;
  final int quantity;
  final String? observation;
  final int status;
  final String billID;
  final DateTime createdAt;
  final DateTime? updatedAt;

  RequestItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.observation,
      required this.status,
      required this.billID, 
      required this.createdAt,
      required this.updatedAt,});
}
