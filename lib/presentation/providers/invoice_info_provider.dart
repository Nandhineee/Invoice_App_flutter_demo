import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:invoice/data/datasource/local/invoice_data_source.dart';
import 'package:invoice/data/repositories/invoice_repository_impl.dart';
import 'package:invoice/domain/models/invoice_list.dart';

import '../../domain/repositories/invoice_repository.dart';

final invoiceInfoDataSource = Provider((ref) => InvoiceDataSource());

final invoiceInfoRepositoryProvider = Provider((ref) {
  final invoiceInfoDetailsDataSource = ref.read(invoiceInfoDataSource);
  return InvoiceRepositoryImpl(invoiceInfoDetailsDataSource);
});

final invoiceInfoProvider = StateNotifierProvider((ref) {
  InvoiceRepository invoiceRepository = ref.read(invoiceInfoRepositoryProvider);
  return InvoiceInfoNotifier(
      Invoice("", 0,0, "", "", false, DateTime.now(), DateTime.now(), "", "", "",
          0, "", "", "", "", "", 0, "", "", "", ""),
      invoiceRepository);
});

class InvoiceInfoNotifier extends StateNotifier<Invoice> {
  final InvoiceRepository invoiceRepository;

  InvoiceInfoNotifier(super.state, this.invoiceRepository);



  void getInvoiceInfo(String id, String invoiceName, DateTime createdDate,
      DateTime dueDate, String dueTerms) {
    state.id = id;


    state.invoiceName = invoiceName;
    state.createdDate = createdDate;
    state.dueDate = dueDate;
    state.dueTerms = dueTerms;
  }

  void getBusinessInfo(
    String businessName,
    String businessEmailAddress,
    String businessPhone,
    String businessBillingAddress,
    String businessWebsite,
  ) {
    state.businessName = businessName;
    state.businessEmailAddress = businessEmailAddress;
    try {
      state.businessPhone = int.parse(businessPhone);
    } catch (e) {
      // Handle the error or assign a default value
      print('Error parsing businessPhone: $e');
      state.businessPhone = 0; // Example default value
    }
    state.businessBillingAddress = businessBillingAddress;
    state.businessWebsite = businessWebsite;
     print(state.toJson().toString() );
     print("business");
  }

  void getClientInfo(
    String clientName,
    String clientEmailAddress,
    String clientPhone,
    String clientBillingAddress,
    String clientShippingAddress,
  ) {
    state.clientName=clientName;
    state.clientEmailAddress=clientEmailAddress;
    try {
      state.clientPhone = int.parse(clientPhone);
    } catch (e) {
      // Handle the error or assign a default value
      print('Error parsing businessPhone: $e');
      state.clientPhone = 0; // Example default value
    }
    state.clientBillingAddress=clientBillingAddress;
    state.clientShippingAddress=clientShippingAddress;

    print("client");

  }

  void getInvoiceDiscount(String discount){
    state.discount=discount;

  }

  void getInvoiceTax(String tax){
    state.tax=tax;

  }

  void getInvoiceShipping(String shipping){
    state.shipping=shipping;
    print(state.toJson().toString() );
    print("shipping");

  }


  //
  Future<void> createInvoice(int uid)async {

      state.userId = uid;
      print("User ID updated to: ${state.userId}");
      await invoiceRepository.invoice(state);


    print(state.toJson().toString() );
    print("create checking");

  }
}
