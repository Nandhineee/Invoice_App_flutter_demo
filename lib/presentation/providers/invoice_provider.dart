import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/data/datasource/local/invoice_data_source.dart';
import 'package:invoice/data/repositories/invoice_repository_impl.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/domain/repositories/invoice_repository.dart';

final invoiceDataSourceProvider= Provider((ref) => InvoiceDataSource());




final invoiceRepositoryProvider=Provider<InvoiceRepository>((ref) {
  final invoiceDetailsDataSource=ref.read(invoiceDataSourceProvider);
  return InvoiceRepositoryImpl(invoiceDetailsDataSource);
});


final invoiceDetailsProvider = StateNotifierProvider<InvoiceDetailsNotifier,List<Invoice>>((ref) {
  InvoiceRepository invoiceRepository=ref.read(invoiceRepositoryProvider);
  return InvoiceDetailsNotifier([],invoiceRepository);
});

class InvoiceDetailsNotifier extends StateNotifier<List<Invoice>>{
  final InvoiceRepository invoiceRepository;
InvoiceDetailsNotifier(super.state, this.invoiceRepository);



  Future<void> createInvoice(Invoice invoice) async {
    print("$state  create");
    await invoiceRepository.invoice(invoice);
  }

  Future<void> getInvoice()async {
    state = (await invoiceRepository.getInvoice())!;

  }



  getInvoices(){
    return state;
  }

  List<Invoice> getPaidInvoices(bool paid) {
    List<Invoice> filteredPaidInvoices = state.where((invoice) => invoice.paid == true).toList();
    for (Invoice invoice in state) {
      print(invoice.toJson());
    }
    print(filteredPaidInvoices);
    return filteredPaidInvoices;
  }

  List<Invoice> getUnPaidInvoices(bool paid) {
    List<Invoice> filteredUnpaidInvoices = state.where((invoice) => invoice.paid == false).toList();
    print(filteredUnpaidInvoices);
    return filteredUnpaidInvoices;
  }



  Future<void> deleteById(String inId) async {
    await invoiceRepository.deleteInvoice(inId);
    // Fetch the updated list of invoices after deletion
    await getInvoice();
  }

Future<void> updateInvoice(Invoice editInvoice,String iId) async {
     await invoiceRepository.updateInvoice(editInvoice, iId);
}

}
