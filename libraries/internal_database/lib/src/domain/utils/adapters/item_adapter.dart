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
      productId: product.id,
      requestId: requestID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static List<MinimizedItem> toMinimalizedItems(
      List<ItemData> items, List<ProductData> products,) {
    final groupedItems = <MinimizedItem>[];
    for (final item in items) {
      final product =
          products.firstWhere((element) => element.id == item.productId);
      groupedItems.add(toMinimalizedItem(item, product.name, product.code));
    }
    return groupedItems;
  }

  static List<Item> toItems(List<ItemData> items, List<ProductData> products) {
    final groupedItems = <Item>[];
    for (final item in items) {
      final product =
          products.firstWhere((element) => element.id == item.productId);
      groupedItems.add(toItem(item, product.name, product.code));
    }
    return groupedItems;
  }

  static MinimizedItem toMinimalizedItem(
      ItemData item, String productName, int? code,) {
    return MinimizedItem(name: productName, quantity: item.quantity);
  }

  static Item toItem(ItemData item, String productName, int? code) {
    return Item(
      id: item.id,
      name: productName,
      code: code,
      price: item.price,
      quantity: item.quantity,
      totalQuantity: item.totalQuantity,
      status: item.status,
      productId: item.productId,
      requestId: item.requestId,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }
}
