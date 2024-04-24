import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/presentation/providers/invoice_provider.dart';

import '../../providers/item_price_provider.dart';

class Unpaid extends ConsumerStatefulWidget {
  const Unpaid({super.key});

  @override
  ConsumerState <Unpaid> createState() => _UnpaidState();
}

class _UnpaidState extends ConsumerState<Unpaid> {
  late List<Invoice> unpaidInvoices=[];



  @override

  void initState() {

    unpaidInvoices = ref.read(invoiceDetailsProvider.notifier).getUnPaidInvoices(false);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: unpaidInvoices.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                // Adjust space around each container for better visibility of the shadow
                decoration: BoxDecoration(
                  color: Colors.white70,
                  // Background color of the container
                  borderRadius: BorderRadius.circular(10.0),
                  // Border corner radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      // Shadow color with opacity
                      spreadRadius: 2,
                      // Spread radius
                      blurRadius: 7,
                      // Blur radius
                      offset: const Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  leading:  CircleAvatar(
                    backgroundColor: Colors.blue[900],
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align items to the start
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // Align text to the start of the column
                            children: <Widget>[
                              Text(
                                unpaidInvoices[index].invoiceName,
                                style: const  TextStyle(
                                  fontSize: 20.0, // Size of the first text
                                ),
                              ),
                              Text(
                                unpaidInvoices[index].id,
                                // Your additional text
                                style: const TextStyle(
                                  fontSize:
                                  20.0, // Adjust the size as per your need
                                ),
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
                              icon: const  Icon(
                                Icons.delete,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                await ref.read(invoiceDetailsProvider.notifier).deleteById(unpaidInvoices[index].id);
                                await ref.read(invoiceDetailsProvider.notifier).getInvoices();

                                setState(() {

                                });

                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Text(
              ref.read(itemPriceProvider.notifier).getPrice(unpaidInvoices[index].id),
                              style: const TextStyle(
                                fontSize: 15.0, // You can adjust the size as per your need
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  // Add trailing widget if needed
                ),
              );
            },
          ),
        ),
      ],
    );

  }
}
