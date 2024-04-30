import 'package:invoice/data/datasource/local/invoice_data_source.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/domain/models/user.dart';
import 'package:invoice/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  final InvoiceDataSource invoiceDataSource;

  InvoiceRepositoryImpl(this.invoiceDataSource);

  @override
  Future<bool> invoice(Invoice invoice) async {


    bool? result = await invoiceDataSource.insertInvoiceData(invoice);
    if (result!) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<Invoice>?> getInvoice(int id) async {
    List<Invoice>? result = await invoiceDataSource.getInvoice(id);
    if (result!.isNotEmpty) {
      return result;
    }
    return null;
  }

  @override
  Future<List<Invoice>?> getUpdateInvoice(String iId) async {
    List<Invoice>? result = await invoiceDataSource.getUpdatedInvoice(iId);
    if (result!.isNotEmpty) {
      return result;
    }
    return null;
  }

  @override
  Future<void> deleteInvoice(String inId) async {
    await invoiceDataSource.deleteInvoiceById(inId);

  }

  @override
  Future<void> updateInvoice(Invoice editInvoice, String iId) async {
    invoiceDataSource.updateInvoice(editInvoice, iId);
  }
}
