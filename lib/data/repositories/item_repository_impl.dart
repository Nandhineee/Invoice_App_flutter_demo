import 'package:invoice/data/datasource/local/invoice_data_source.dart';
import 'package:invoice/domain/models/item.dart';
import 'package:invoice/domain/repositories/item_repository.dart';
@override
class ItemRepositoryImpl extends ItemRepository{

  final InvoiceDataSource invoiceDataSource;

  ItemRepositoryImpl(this.invoiceDataSource);
  @override
   Future<bool> item(Item item) async{



      bool? result = await invoiceDataSource.insertItemData(item);

      if (result!) {
        return true;
      } else {
        return false;
       }

  }

  @override
  Future<List<Item>?> getItem() async {
    List<Item>? result= await invoiceDataSource.getItem();
    if(result!.isNotEmpty) {
      return result;

    }
    return null;

  }
}




