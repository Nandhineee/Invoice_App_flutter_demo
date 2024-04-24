import 'package:invoice/domain/models/item.dart';

abstract class ItemRepository {
  Future<bool> item(Item item);

  Future<List<Item>?> getItem();
}
