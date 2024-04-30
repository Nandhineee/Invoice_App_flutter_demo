import 'package:flutter/material.dart';

import 'package:invoice/domain/models/item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdf extends StatefulWidget {
  const InvoicePdf({
    super.key,
    required this.invoiceName,
    required this.dueTerms,
    required this.createdDate,
    required this.dueDate,
    required this.businessName,
    required this.businessWebsite,
    required this.businessEmailAddress,
    required this.businessBillingAddress,
    required this.clientName,
    required this.clientPhone,
    required this.clientShippingAddress,
    required this.clientBillingAddress,
    required this.clientEmailAddress,
    required this.discount,
    required this.tax,
    required this.shipping,
    required this.invoiceId,
    required this.itemList,
  });

  final String invoiceId;
  final String invoiceName;
  final String dueTerms;
  final DateTime createdDate;
  final DateTime dueDate;
  final String businessWebsite;
  final String businessName;

  final String businessEmailAddress;
  final String businessBillingAddress;
  final String clientName;
  final num clientPhone;
  final String clientShippingAddress;
  final String clientBillingAddress;
  final String clientEmailAddress;
  final String discount;
  final String tax;
  final String shipping;
  final List<Item> itemList;

  @override
  State<InvoicePdf> createState() => _InvoicePdfState();
}

class _InvoicePdfState extends State<InvoicePdf> {
  late String invoiceId;
  late String invoiceName;
  late String dueTerms;
  late DateTime createdDate;
  late DateTime dueDate;
  late String businessName;
  late String businessWebsite;
  late String businessEmailAddress;
  late String businessBillingAddress;
  late String clientName;
  late num clientPhone;
  late String clientShippingAddress;
  late String clientBillingAddress;
  late String clientEmailAddress;
  late String discount;
  late String tax;
  late String shipping;
  late String itemId;
  late String itemName;
  late num itemPrice;
  late num quantity;
  late num itemDiscount;
  late num itemTax;
  late List<Item> itemsList;

  @override
  void initState() {
    super.initState();
    invoiceId = widget.invoiceId;
    clientName = widget.clientName;
    invoiceName = widget.invoiceName;
    dueTerms = widget.dueTerms;
    createdDate = widget.createdDate;
    dueDate = widget.dueDate;
    businessName = widget.businessName;
    businessWebsite = widget.businessWebsite;
    businessEmailAddress = widget.businessEmailAddress;
    businessBillingAddress = widget.businessBillingAddress;
    clientPhone = widget.clientPhone;
    clientShippingAddress = widget.clientShippingAddress;
    clientBillingAddress = widget.clientBillingAddress;
    clientEmailAddress = widget.clientEmailAddress;
    discount = widget.discount;
    tax = widget.tax;
    shipping = widget.shipping;
    itemsList = widget.itemList;
  }

  Future<void> generateInvoicePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(invoiceId, style: const pw.TextStyle(fontSize: 24)),
              pw.Text(invoiceName,
                  style: pw.TextStyle(
                      fontSize: 50, color: PdfColor.fromRYB(0, 0, 1))),
              pw.SizedBox(height: 10),
              pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Client Name: ',
                    ),
                    pw.TextSpan(
                      text: clientName,
                      style: pw.TextStyle(
                        color: PdfColor.fromRYB(0, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Client Phone: ',
                    ),
                    pw.TextSpan(
                      text: '$clientPhone',
                      style: pw.TextStyle(
                        color: PdfColors.blue.shade(900.0),
                      ),
                    ),
                  ],
                ),
              ),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Client Email: ',
                    ),
                    pw.TextSpan(
                      text: clientEmailAddress,
                      style: pw.TextStyle(
                        color: PdfColors.blue.shade(900.0),
                      ),
                    ),
                  ],
                ),
              ),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Client Address: ',
                    ),
                    pw.TextSpan(
                      text: clientShippingAddress,
                      style: pw.TextStyle(
                        color: PdfColors.blue.shade(900.0),
                      ),
                    )
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Business Name: ',
                    ),
                    pw.TextSpan(
                      text: businessWebsite,
                      style: pw.TextStyle(
                        color: PdfColor.fromRYB(0, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Business Email: ',
                    ),
                    pw.TextSpan(
                      text: businessEmailAddress,
                      style: pw.TextStyle(
                        color: PdfColors.blue.shade(900.0),
                      ),
                    ),
                  ],
                ),
              ),
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    const pw.TextSpan(
                      text: 'Business Address: ',
                    ),
                    pw.TextSpan(
                      text: businessBillingAddress,
                      style: pw.TextStyle(
                        color: PdfColors.blue.shade(900.0),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Items',
                      style: pw.TextStyle(
                          fontSize: 18, color: PdfColor.fromRYB(0, 0, 1))),
                  pw.Text('Quantity x Price',
                      style: pw.TextStyle(
                          fontSize: 18, color: PdfColor.fromRYB(0, 0, 1))),
                ],
              ),
              pw.ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  final item = itemsList[index];
                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(item.name,
                          style: const pw.TextStyle(fontSize: 14)),
                      pw.Text('${item.price} x \$${item.quantity}',
                          style: const pw.TextStyle(fontSize: 14)),
                    ],
                  );
                },
              ),

              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Discount: \$${discount}',
                    style: pw.TextStyle(fontSize: 14)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Tax: \$${tax}',
                    style: pw.TextStyle(fontSize: 14)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Shipping: \$${shipping}',
                    style: pw.TextStyle(fontSize: 14)),
              ),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: \$${(itemsList.fold(0.0, (double total, item) => total + item.price * item.quantity) - (double.tryParse(discount) ?? 0) + (double.tryParse(tax) ?? 0) + (double.tryParse(shipping) ?? 0)).toStringAsFixed(2)}',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: \$${(itemsList.fold(0.0, (double total, item) => total + item.price * item.quantity) - (double.tryParse(discount) ?? 0) + (double.tryParse(tax) ?? 0) + (double.tryParse(shipping) ?? 0)).toStringAsFixed(2)}',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),


              ),
            ],
          );
        },
      ),
    );
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'invoice.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              void printItemsList() {
                for (Item item in itemsList) {
                  print('Item Name: ${item.name}');
                  print('Item ID: ${item.price}');
                  print('Invoice ID: ${item.quantity}');
                  print('Item Price: \$${item.discount}');
                  print('Quantity: ${item.tax}');

                  print('------------------------');
                }
              }
              printItemsList();
              Navigator.pop(context);
            }),
        title: const Text(
          'Invoice Details',
          style: TextStyle(
            color: Colors.white, // Set your desired color here
          ),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(invoiceId,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(invoiceName,
                      style:
                          TextStyle(fontSize: 50, color: Colors.blue.shade900)),
                  Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
                  const SizedBox(height: 20),
                  const Divider(),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .black, // Default text color for the whole TextSpan
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Client Name: '),
                        TextSpan(
                          text: clientName,
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Default text color
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'clientPhone: '),
                        TextSpan(
                          text: '$clientPhone',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Default text color
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'clientEmail: '),
                        TextSpan(
                          text: clientEmailAddress,
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Default text color
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'client Address: '),
                        TextSpan(
                          text: clientShippingAddress,
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Business Website: '),
                        TextSpan(
                          text: businessName,
                          style: TextStyle(
                              color: Colors
                                  .blue.shade900), // Style for variable content
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Default text color for labels
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Business Email: '),
                        TextSpan(
                          text: businessEmailAddress,
                          style: TextStyle(
                              color: Colors
                                  .blue.shade900), // Style for variable content
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Default text color for labels
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Business Address: '),
                        TextSpan(
                          text: businessBillingAddress,
                          style: TextStyle(
                              color: Colors
                                  .blue.shade900), // Style for variable content
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Items',
                          style: Theme.of(context).textTheme.titleLarge),
                      Text('Price',
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(itemsList[index].name),
                        subtitle: Text(
                          'Quantity: ${itemsList[index].price}',
                          style: TextStyle(
                            color: Colors.blue, // Sets the text color to blue
                          ),
                        ),

                          trailing: Text('\$${itemsList[index].quantity}'),
                      );
                    },
                  ),
                  const Divider(),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Discount: \$$discount'),
                        Text('Tax: \$$tax'),
                        Text('Shipping: \$$shipping'),
                      ],
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      // Calculate total
                      'Total: \$${(itemsList.fold(0.0, (double total, item) => total + item.price * item.quantity) - (double.tryParse(discount) ?? 0) + (double.tryParse(tax) ?? 0) + (double.tryParse(shipping) ?? 0)).toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.blue),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: TextButton(
                onPressed: generateInvoicePDF,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade900, // Text color
                ),
                child: const Text('Generate PDF'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
