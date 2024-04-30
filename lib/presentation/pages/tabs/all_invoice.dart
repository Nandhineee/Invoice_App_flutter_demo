import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/presentation/providers/invoice_provider.dart';
import 'package:invoice/presentation/providers/item_price_provider.dart';


import '../../providers/user_provider.dart';

class AllInvoice extends ConsumerStatefulWidget {
  const AllInvoice({super.key});

  @override
  ConsumerState<AllInvoice> createState() => _Allinvoicestate();
}

class _Allinvoicestate extends ConsumerState<AllInvoice> {


  @override
  void initState() {
    ref.read(itemPriceProvider.notifier).storeItem();

    super.initState();
  }
  late List<Invoice> invoiceData = [];



  @override
  Widget build(BuildContext context) {
   invoiceData = ref.watch(invoiceDetailsProvider);
   ref.read(invoiceDetailsProvider.notifier).getInvoice(
       ref.read(authUserDetailsProvider.notifier).getAuthUserDetails().id);


    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: invoiceData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                  String editedText = invoiceData[index].invoiceName;
                  // Show dialog when list item is tapped
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(child: Text('Edit Invoice')),
                        content: TextField(
                          controller: TextEditingController(
                              text: invoiceData[index].invoiceName),
                          onChanged: (value) {

                            editedText = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter new invoice name",
                          ),
                        ),

                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {


                              // And if necessary, trigger a state update
                            },
                            child: const Text('Save'),
                          ),
                        ],);
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[900],
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  invoiceData[index].invoiceName,
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  invoiceData[index].id,
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    size: 20.0, color: Colors.black),
                                onPressed: () async {
                                  // Showing a dialog to confirm deletion
                                  final bool? confirmDelete =
                                      await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm'),
                                        content: const Text(
                                            'Are you sure you want to delete this item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(
                                                    false), // User pressed "No"
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            // User pressed "Yes"
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (confirmDelete == true) {
                                    // Perform the deletion and other related operations
                                    await ref
                                        .read(invoiceDetailsProvider.notifier)
                                        .deleteById(invoiceData[index].id);
                                    await ref
                                        .read(invoiceDetailsProvider.notifier)
                                        .getInvoice(ref.read(authUserDetailsProvider.notifier).getAuthUserDetails().id);
                                    invoiceData = ref
                                        .read(invoiceDetailsProvider.notifier)
                                        .getInvoices();
                                    setState(() {});

                                    // Here, replace the commented out code with actual calls to your state management solution
                                    // and update the UI accordingly.
                                  }
                                },

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(), // Define specific padding values as needed
                              child: Text(
                                '₹${double.parse(ref.read(itemPriceProvider.notifier).getPrice(invoiceData[index].id)).round()}',
                                style: const TextStyle(fontSize: 15.0),
                              ),
                            ),




                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
