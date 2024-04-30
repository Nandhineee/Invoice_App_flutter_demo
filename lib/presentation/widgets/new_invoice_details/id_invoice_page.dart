import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/domain/models/item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:invoice/presentation/pages/details_page/item_info.dart';
import 'package:invoice/presentation/pages/invoice_pdf/pdf_file.dart';
import 'package:invoice/presentation/providers/invoice_info_provider.dart';
import 'package:invoice/presentation/providers/localizations_provider.dart';


import 'package:invoice/presentation/providers/invoice_provider.dart';
import 'package:invoice/presentation/providers/item_provider.dart';

import '../../pages/details_page/business_info.dart';
import '../../pages/details_page/client_info.dart';
import '../../pages/details_page/invoice_info.dart';
import '../../providers/user_provider.dart';

//315 app localisation

class Idinfo extends ConsumerStatefulWidget {
  const Idinfo({super.key});

  @override
  ConsumerState<Idinfo> createState() => _IdinfoState();
}

class _IdinfoState extends ConsumerState<Idinfo> {
  late List<Invoice> invoiceList;
  List<Item> itemsList = [];
   String invoiceId = "";
  String invoiceName = "";
  String price = "";
  DateTime createdDate = DateTime.now();
  DateTime dueDate = DateTime.now();
   String dueTerms = "";
  int clientPhone = 0;
  String clientBillingAddress = "";
  String clientShippingAddress = "";
  String clientName = "";
  String clientEmailAddress = "";

  String businessName = "";
  String businessEmailAddress = "";
  int businessPhone = 0;
  String businessBillingAddress = "";
  String businessWebsite = "";
  String discount = "";
  String tax = "";
  String shipping = "";
  num itemId = 0;
  String itemName = "";
  num itemPrice = 0;
  num quantity = 0;
  num itemDiscount = 0;
  num itemTax = 0;

  @override
  void initState() {
    super.initState();
    invoiceId = invoiceId;
    invoiceName = invoiceName;
    dueTerms = dueTerms;
    createdDate = createdDate;
    dueDate = dueDate;
    businessWebsite = businessWebsite;
    businessEmailAddress = businessEmailAddress;
    businessWebsite = businessWebsite;
    businessBillingAddress = businessBillingAddress;
    clientName = clientName;
    clientPhone = clientPhone;
    clientShippingAddress = clientShippingAddress;
    clientBillingAddress = clientBillingAddress;
    clientEmailAddress = clientEmailAddress;
    discount = _discountController.text;
    tax = _taxController.text;
    shipping = shipping;
    itemId = itemId;
    itemName = itemName;
    itemPrice = itemPrice;
    quantity = quantity;
    itemDiscount = itemDiscount;
    itemTax = itemTax;
  }

  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _shippingController = TextEditingController();

  void navigateToAddTodoPage(BuildContext context, List<Item> itemsList) async {
    // Assuming non-nullable types for numeric and DateTime fields, and checking for emptiness for String and List types.
    bool isValid = invoiceName.isNotEmpty &&
        dueTerms.isNotEmpty &&
        businessName.isNotEmpty &&
        businessWebsite.isNotEmpty &&
        businessEmailAddress.isNotEmpty &&
        businessBillingAddress.isNotEmpty &&
        clientName.isNotEmpty &&
        clientShippingAddress.isNotEmpty &&
        clientBillingAddress.isNotEmpty &&
        clientEmailAddress.isNotEmpty &&
        itemsList.isNotEmpty &&
        discount.isNotEmpty;

    if (isValid) {
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InvoicePdf(
                  invoiceId: invoiceId,
                  invoiceName: invoiceName,
                  dueTerms: dueTerms,
                  createdDate: createdDate,
                  dueDate: dueDate,
                  businessName: businessName,
                  businessWebsite: businessWebsite,
                  businessEmailAddress: businessEmailAddress,
                  businessBillingAddress: businessBillingAddress,
                  clientName: clientName,
                  clientPhone: clientPhone,
                  clientShippingAddress: clientShippingAddress,
                  clientBillingAddress: clientBillingAddress,
                  clientEmailAddress: clientEmailAddress,
                  discount: discount,
                  tax: tax,
                  shipping: shipping,
                  itemList: itemsList,
                )),
      );

      print("create checking");
      ref.read(invoiceInfoProvider.notifier).createInvoice(ref.read(authUserDetailsProvider.notifier).getAuthUserDetails().id);
      for (var item in itemsList) {
        ref.read(itemDetailsProvider.notifier).createItem(item);
        ref.read(invoiceDetailsProvider.notifier).getInvoice(ref.read(authUserDetailsProvider.notifier).getAuthUserDetails().id);

      }
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localizationProvider);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
              child: Container(
                height: 100.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  // Gives rounded corners for a nicer look
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 8.0,
                      offset: const Offset(4.0, 4.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            invoiceId.isNotEmpty ? invoiceId : AppLocalizations.of(context)!.invoicenumber,
                            style: TextStyle(
                              fontSize: invoiceId.isNotEmpty ? 35.0 : 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            invoiceName.isNotEmpty ? invoiceName : AppLocalizations.of(context)!.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            createdDate != null
                                ? formatDate(createdDate)
                                : 'Created Date',
                            // Check if createdDate is null
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Colors.blue[900]),
                          onPressed: () async {
                            final Map<String, dynamic>? result =
                                await Navigator.push<Map<String, dynamic>>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvoiceInfo(
                                  invoiceId: invoiceId,
                                  invoiceName: invoiceName,
                                  createdDate: createdDate,
                                  dueTerms: dueTerms,
                                  dueDate: dueDate,
                                ),
                              ),
                            );

                            if (result != null) {
                              setState(() {
                                invoiceId = result['invoiceId'];
                                invoiceName = result['invoiceName'];
                                createdDate =
                                    DateTime.parse(result['createdDate']);
                                dueDate = DateTime.parse(result['dueDate']);
                                dueTerms = result['dueTerms'];
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Details submitted successfully!'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.green),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
              child: Container(
                height: 150.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 8.0,
                      offset: const Offset(
                          4.0, 4.0), // X, Y offset from the container
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            // First Column
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 05.0, bottom: 05.0),
                                    child: Icon(Icons.mail_outline, size: 23.0),
                                  ),
                                  const SizedBox(width: 8.0),
                                   Padding(
                                    padding: EdgeInsets.only(
                                        top: 05.0, bottom: 05.0),
                                    child: Text(
                                       AppLocalizations.of(context)!.all,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: Colors.blue[900]),
                                    onPressed: () async {
                                      final Map<String, dynamic>? result =
                                          await Navigator.push<
                                              Map<String, dynamic>>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BusinessInfo(
                                            businessName: businessName,
                                            businessPhone: businessPhone,
                                            businessEmailAddress:
                                                businessEmailAddress,
                                            businessWebsite: businessWebsite,
                                            businessBillingAddress:
                                                businessBillingAddress,
                                          ),
                                        ),
                                      );

                                      if (result != null) {
                                        setState(() {
                                          businessName =
                                              result['businessName'] ?? '';
                                          businessWebsite =
                                              result['businessWebsite'] ?? '';
                                          businessEmailAddress =
                                              result['businessEmailAddress'] ??
                                                  '';
                                          businessBillingAddress = result[
                                                  'businessBillingAddress'] ??
                                              '';
                                          businessPhone = result.containsKey(
                                                      'businessPhone') &&
                                                  result['businessPhone'] !=
                                                      null
                                              ? int.tryParse(
                                                      result['businessPhone']
                                                          .toString()) ??
                                                  0
                                              : 0;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Business Details submitted successfully!'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      Colors.green));
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 2.0),
                                  Text(AppLocalizations.of(context)!.addbusiness),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Column(
                            // Second Column, placed below the first Column
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // Ensures alignment to the start
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 16.0, bottom: 1.0),
                                    child: Icon(Icons.receipt_long, size: 23.0),
                                  ),
                                  // Icon with specific padding
                                  const SizedBox(width: 8.0),
                                  // Space between icon and text
                                   Padding(
                                    padding:
                                        const EdgeInsets.only(top: 16.0, bottom: 1.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.billto,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // // Bold text label
                                  const Spacer(),
                                  // This pushes the IconButton to the far right
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: Colors.blue[900]),
                                    onPressed: () async {
                                      final Map<String, dynamic>? result =
                                          await Navigator.push<
                                              Map<String, dynamic>>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ClientInfo(
                                            clientName: clientName,
                                            clientPhone: clientPhone,
                                            clientEmailAddress:
                                                clientEmailAddress,
                                            clientShippingAddress:
                                                clientShippingAddress,
                                            clientBillingAddress:
                                                clientBillingAddress,
                                          ),
                                        ),
                                      );

                                      if (result != null) {
                                        setState(() {
                                          clientName = result['clientName'] ??
                                              'Nandhini';
                                          clientEmailAddress =
                                              result['clientEmailAddress'] ??
                                                  'nandhini@gmail.com';

                                          clientShippingAddress =
                                              result['clientShippingAddress'] ??
                                                  '';
                                          clientBillingAddress =
                                              result['clientBillingAddress'] ??
                                                  '';
                                          // Use null-aware operators to provide a default value if the result is null
                                          clientPhone = result.containsKey(
                                                      'clientPhone') &&
                                                  result['clientPhone'] != null
                                              ? int.tryParse(
                                                      result['clientPhone']
                                                          .toString()) ??
                                                  0
                                              : 0;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Client Details submitted successfully!'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      Colors.green));
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 3.0),
                                  // Offset to align text under the first one
                                  Text(AppLocalizations.of(context)!.addclient),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
              child: Container(
                height: 420.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 8.0,
                      offset: const Offset(4.0, 4.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.shopping_cart, color: Colors.black),
                          const SizedBox(width: 8.0),
                          Text(AppLocalizations.of(context)!.item, style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      InkWell(
                        onTap: () async {
                          final Map<String, dynamic>? result =
                              await Navigator.push<Map<String, dynamic>>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemInfo(
                                itemId: itemId,
                                itemName: itemName,
                                itemPrice: itemPrice,
                                itemDiscount: itemDiscount,
                                itemTax: itemTax,
                                quantity: quantity,
                              ),
                            ),
                          );

                          // Check if the result is not null and then update the state variables
                          if (result != null) {
                            setState(() {
                              itemId = 0;
                              itemName = result['itemName'] ?? '';
                              String itemPriceStr = result['itemPrice'] ?? '';
                              itemPrice = num.tryParse(itemPriceStr) ?? 0;
                              String itemDiscountStr =
                                  result['itemDiscount'] ?? '';
                              itemDiscount = num.tryParse(itemDiscountStr) ?? 0;
                              String itemTaxStr = result['itemTax'] ?? '';
                              itemTax = num.tryParse(itemTaxStr) ?? 0;
                              String quantityStr = result['quantity'] ?? '';
                              quantity = num.tryParse(quantityStr) ?? 0;

                              double priceAfterDiscount =
                                  itemPrice - (itemPrice * itemDiscount / 100);
                              double taxAmount =
                                  priceAfterDiscount * (itemTax / 100);
                              double finalPrice =
                                  priceAfterDiscount + taxAmount;

                              Item itemData = Item(invoiceId, itemId, itemName,
                                  finalPrice, quantity, itemDiscount, itemTax);

                              itemsList.add(itemData);
                              setState(() {

                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Item Added successfully! Final price: \$${finalPrice.toStringAsFixed(2)}'),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.green));
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.add, color: Colors.black),
                              SizedBox(width: 8.0),
                              Text(AppLocalizations.of(context)!.additem,
                                  style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             Text(
                              AppLocalizations.of(context)!.quantity,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text('$quantity',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Row for the discount icon, text, and greater than symbol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Align items on both ends
                        children: <Widget>[
                          // Container for the discount icon and text on the left
                           Row(
                            children: <Widget>[
                              const Icon(Icons.discount, color: Colors.black),
                              // Discount icon
                              const SizedBox(width: 8.0),
                              // Spacing between icon and text
                              Text(AppLocalizations.of(context)!.discount,
                                  style: const TextStyle(fontSize: 16.0)),
                              // Discount text
                            ],
                          ),
                          // IconButton for the greater than icon on the right
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: Colors.indigo[900]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.discount,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.indigo[900]),
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              width: 400,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: TextFormField(
                                                controller: _discountController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: '0%',
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 16.0),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    discount =
                                                        _discountController
                                                            .text;

                                                    Map<String, dynamic>
                                                        result = {
                                                      'discount': discount,
                                                    };
                                                    ref
                                                        .read(
                                                            invoiceInfoProvider
                                                                .notifier)
                                                        .getInvoiceDiscount(
                                                            discount);
                                                    Navigator.pop(
                                                        context, result);
                                                  },
                                                  child: const Text('Save'),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),
                      // Row for the discount icon, text, and greater than symbol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Align items on both ends
                        children: <Widget>[
                          // Container for the discount icon and text on the left
                           Row(
                            children: <Widget>[
                              const Icon(Icons.account_balance, color: Colors.black),
                              // Discount icon
                              const SizedBox(width: 8.0),
                              // Spacing between icon and text
                              Text(AppLocalizations.of(context)!.tax, style: const TextStyle(fontSize: 16.0)),
                              // Discount text
                            ],
                          ),
                          // IconButton for the greater than icon on the right
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.indigo[900]),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.tax,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigo[900]),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: TextFormField(
                                                  controller: _taxController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: '0%',
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      tax =
                                                          _taxController
                                                              .text;

                                                      Map<String, dynamic>
                                                          result = {
                                                        'tax': tax,
                                                      };
                                                      ref
                                                          .read(
                                                              invoiceInfoProvider
                                                                  .notifier)
                                                          .getInvoiceTax(
                                                              tax);
                                                      Navigator.pop(
                                                          context, result);
                                                    },
                                                    child: const Text('Save'),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // Row for the discount icon, text, and greater than symbol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Align items on both ends
                        children: <Widget>[
                          // Container for the discount icon and text on the left
                           Row(
                            children: <Widget>[
                              const Icon(Icons.local_shipping, color: Colors.black),
                              // Discount icon
                              const SizedBox(width: 8.0),
                              // Spacing between icon and text
                              Text(AppLocalizations.of(context)!.shipping,
                                  style: const TextStyle(fontSize: 16.0)),
                              // Discount text
                            ],
                          ),
                          // IconButton for the greater than icon on the right
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.indigo[900]),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Shipping Amount',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigo[900]),
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      _shippingController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: '0',
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      shipping =
                                                          _shippingController
                                                              .text;

                                                      Map<String, dynamic>
                                                          result = {
                                                        'shipping': shipping,
                                                      };
                                                      ref
                                                          .read(
                                                              invoiceInfoProvider
                                                                  .notifier)
                                                          .getInvoiceShipping(
                                                              shipping);
                                                      Navigator.pop(
                                                          context, result);
                                                    },
                                                    child: const Text('Save'),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // payment_info()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddTodoPage(context, itemsList);
        },
        // The add symbol
        backgroundColor: Colors.blue[900],

        shape: const CircleBorder(),
        child: const Icon(
          Icons.send_outlined,
          color: Colors.white, // Set the icon color to white
        ),
      ),
    );
  }
}
