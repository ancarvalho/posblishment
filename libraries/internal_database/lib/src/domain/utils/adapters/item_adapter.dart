import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:uuid/uuid.dart';

class ItemAdapter {
  static ItemData createItem(NewItem item, Product product, String requestID) {
    return ItemData(
      id: const Uuid().v4(),
      price: product.price,
      quantity: item.quantity,
      totalQuantity: item.quantity,
      status: ItemStatus.preparing,
      productId: product.id!,
      requestId: requestID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Item toItem(ItemData item) {
    return Item(
        id: item.id,
        price: item.price,
        quantity: item.quantity,
        totalQuantity: item.totalQuantity,
        status: item.status,
        productId: item.productId,
        requestId: item.requestId,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt);
  }
}
