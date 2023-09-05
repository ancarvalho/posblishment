import '../../core.dart';

class Request {
  final String id;
  final String? observation;
  List<MinimizedItem>? items;
  final RequestStatus status;
  final String billId;
  final DateTime createdAt;
  final DateTime? updatedAt;
   Request({
    required this.id,
    this.observation,
    this.items,
    required this.status,
    required this.billId,
    required this.createdAt,
    this.updatedAt,
  });

  factory Request.empty() {
    return Request(
      billId: "",
      createdAt: DateTime.now(),
      id: "",
      status: RequestStatus.preparing,
      items: [],
    );
  }
}

class NewRequest {
  final String? observation;
  List<NewItem> items;

  NewRequest({
    this.observation,
    required this.items,
  });

  factory NewRequest.empty() {
    return NewRequest(observation: "", items: []);
  }
}
