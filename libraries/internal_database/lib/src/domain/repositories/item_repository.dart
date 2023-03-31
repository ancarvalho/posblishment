import '../entities/entities.dart';

abstract class ItemRepository {
  Future<bool> changeItemStatus(String id, );
  Future<bool> updateItemQuantity(String id, int quantity);
  //
  Future<bool> createItem(Item item);
}
