class Request {
  final String id;
  final String? observation;
  final String billId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Request({
    required this.id,
    this.observation,
    required this.billId,
    required this.createdAt,
    required this.updatedAt,
  });
}
