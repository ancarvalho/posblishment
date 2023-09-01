import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:internal_database/src/domain/utils/adapters/adapters.dart';
import "package:uuid/uuid.dart";

class RequestAdapter {
  static Request fromRequestDataWithItems(
    RequestData requestData,
    List<Item> items,
  ) {
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

  static List<Request> groupRequesWithItems(List<RequestData> requestData,
      List<ItemData> items, List<ProductData> products,) {
    final requests = <Request>[];

    for (final r in requestData) {
      final requestItems =
          items.where((element) => element.requestId == r.id).toList();
      final itemsWithName = ItemAdapter.toItems(requestItems, products);

      requests.add(fromRequestDataWithItems(r, itemsWithName));
    }

    return requests;
  }
}
