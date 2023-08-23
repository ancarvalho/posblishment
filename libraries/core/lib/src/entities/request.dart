import '../../core.dart';

class Request {
  final String id;
  final String? observation;
  final List<Item>? items;
  final RequestStatus status;
  final String billId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Request({
    required this.id,
    this.observation,
    this.items,
    required this.status,
    required this.billId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class NewRequest {
  final String? observation;
  final List<NewItem> items;

  const NewRequest({
    this.observation,
    required this.items,
  });

  factory NewRequest.empty() {
    return const NewRequest(observation: "", items: []);
  }
}
