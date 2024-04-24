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


final itemPriceProvider = StateNotifierProvider<InvoicePriceNotifier,List<Item>>((ref) {
  ItemRepository itemRepository=ref.read(itemDataRepository);
  return InvoicePriceNotifier([],itemRepository);
});

class InvoicePriceNotifier extends StateNotifier<List<Item>> {
  final ItemRepository itemRepository;

  InvoicePriceNotifier(super._state ,this.itemRepository);


   Future<bool>
   storeItem() async {
    state= (await itemRepository.getItem())!;
    return true;
  }


  String getPrice(String invoiceId) {
    num total = 0;
    for (Item item in state) {
      if (item.invoiceId == invoiceId) {

        num itemPrice = item.quantity;
        total += itemPrice;

      }
    }
    // Return the total as a string
    return total.toString();
  }





  getItem(){
    return state;
  }

}