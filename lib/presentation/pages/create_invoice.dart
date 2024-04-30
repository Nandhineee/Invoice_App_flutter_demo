import 'package:flutter/material.dart';
import 'package:invoice/presentation/widgets/new_invoice_details/id_invoice_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/about/invoice_creator_page.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Text('<', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    onPressed: () {
    Navigator.pop(context);
    },


        ),
        title:  Center(
            child: Text(AppLocalizations.of(context)!.createinvoice, style: TextStyle(fontSize: 30.0, color: Colors.black),)
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvoiceCreatorPage(), // Assuming 'John Doe' is the creator
                ),
              );
            },
          ),
        ],
      ),
      body:const Idinfo()
    );


  }
}
