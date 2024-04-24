import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/data/datasource/local/invoice_data_source.dart';
import 'package:invoice/data/repositories/item_repository_impl.dart';
import 'package:invoice/domain/models/item.dart';
import 'package:invoice/domain/repositories/item_repository.dart';

final itemDataSourceProvider = Provider((ref)=> InvoiceDataSource());


final  itemDataRepository = Provider<ItemRepository>((ref){

  final itemDetailsDataSource= ref.read(itemDataSourceProvider);
  return ItemRepositoryImpl(itemDetailsDataSource);

});


final itemDetailsProvider = StateNotifierProvider((ref) {
  ItemRepository itemRepository=ref.read(itemDataRepository);
  return InvoiceDetailsNotifier(itemRepository);
});

class InvoiceDetailsNotifier extends StateNotifier<bool> {
  final ItemRepository itemRepository;

  InvoiceDetailsNotifier(this.itemRepository) :super(false);


  Future<void> createItem(Item item) async {
    try {
      bool result = await itemRepository.item(item);
      state = result;
    } catch (e) {
      state = false;
    }
  }

  // int? getPrice(int invoiceId, List<Item> itemsList) {
  //   for (Item item in itemsList) {
  //     if (item.invoiceId == invoiceId) {
  //       return ;
  //     }
  //   }
  //   return 0;
  // }


  // Future<void> getItem()async {
  //   state = (await invoiceRepository.getItem())!;
  //   print("$state getinvoice");
  // }

  getItem(){
    print("$state");
    return state;
  }

}