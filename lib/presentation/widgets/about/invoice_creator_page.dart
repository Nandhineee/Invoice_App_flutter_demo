import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class InvoiceCreatorPage extends StatefulWidget {
  const InvoiceCreatorPage ({super.key});

  @override
  State<InvoiceCreatorPage> createState() => _State();
}

class _State extends State<InvoiceCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Invoice',
          style: TextStyle(color: Colors.blue), // Set title color to blue
        ),
        automaticallyImplyLeading: false, // Remove the back button (optional)
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),


      body:  SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
              AppLocalizations.of(context)!.about,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
  }
}

