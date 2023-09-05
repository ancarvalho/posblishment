import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:internal_database/src/domain/utils/adapters/adapters.dart';
import "package:uuid/uuid.dart";

class RequestAdapter {
  static Request fromRequestDataWithItems(
    RequestData requestData,
    List<MinimizedItem> items,
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

  static List<Request> transformToRequest(List<RequestItem> requestItems) {
    var map = <String, Request>{};

    for (final element in requestItems) {
      if (map.containsKey(element.id)) {
        map[element.id]
            ?.items!
            .add(MinimizedItem(name: element.name, quantity: element.quantity));
      } else {
        map[element.id] = Request(
          id: element.id,
          status: RequestStatus.values.elementAt(element.status),
          billId: element.billID,
          observation: element.observation,
          items: [
            MinimizedItem(name: element.name, quantity: element.quantity)
          ],
          updatedAt: element.updatedAt,
          createdAt: element.createdAt,
        );
      }
    }
    return map.values.toList();
  }

  static List<Request> groupRequesWithItems(
    List<RequestData> requestData,
    List<ItemData> items,
    List<ProductData> products,
  ) {
    final requests = <Request>[];

    for (final r in requestData) {
      final requestItems =
          items.where((element) => element.requestId == r.id).toList();
      final itemsWithName =
          ItemAdapter.toMinimalizedItems(requestItems, products);

      requests.add(fromRequestDataWithItems(r, itemsWithName));
    }

    return requests;
  }
}
