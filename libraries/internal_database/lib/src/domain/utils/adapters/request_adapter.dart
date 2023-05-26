import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";

class RequestAdapter {
  static Request fromRequestData(RequestData requestData, List<Item> items) {
    return Request(
      id: requestData.id,
      billId: requestData.billId,
      observation: requestData.observation,
      items: items,
      status: requestData.status,
      createdAt: requestData.createdAt,
      updatedAt: requestData.updatedAt,
    );
  }

  static RequestData createRequest(NewRequest request, String billID) {
    return RequestData(
      id: const Uuid().v4(),
      observation: request.observation,
      status: RequestStatus.preparing,
      billId: billID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
