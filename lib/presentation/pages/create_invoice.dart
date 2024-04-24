import 'package:flutter/material.dart';
import 'package:invoice/presentation/widgets/new_invoice_details/id_invoice_page.dart';

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
        title: const Center(
            child: Text("Create Invoice", style: TextStyle(fontSize: 30.0, color: Colors.black),)
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body:const Idinfo()
    );


  }
}
