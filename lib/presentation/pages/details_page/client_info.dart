import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/presentation/providers/invoice_info_provider.dart';

class ClientInfo extends ConsumerStatefulWidget {
  const ClientInfo(
      {super.key,
      required this.clientPhone,
      required this.clientBillingAddress,
      required this.clientShippingAddress,
      required this.clientName,
      required this.clientEmailAddress});

  final String clientName;
  final String clientEmailAddress;
  final num clientPhone;
  final String clientBillingAddress;

  final String clientShippingAddress;

  @override
  ConsumerState<ClientInfo> createState() => _ClientInfoState();
}

class _ClientInfoState extends ConsumerState<ClientInfo> {
  final _formKey = GlobalKey<FormState>();

  late String clientName;
  late String clientEmailAddress;
  late num clientPhone;
  late String clientBillingAddress;
  late String clientShippingAddress;

  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientEmailAddressController =
      TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  final TextEditingController _clientBillingController =
      TextEditingController();
  final TextEditingController _clientshippingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    clientName = widget.clientName;
    clientEmailAddress = widget.clientEmailAddress;
    clientPhone = widget.clientPhone;
    clientBillingAddress = widget.clientBillingAddress;
    clientShippingAddress = widget.clientShippingAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Center(
            child: Text(
              "New Client",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String clientName = _clientNameController.text;
                  String clientEmailAddress =
                      _clientEmailAddressController.text;
                  String clientPhone = _clientPhoneController.text;
                  String clientBillingAddress = _clientBillingController.text;
                  String clientShippingAddress = _clientshippingController.text;

                  Map<String, dynamic> invoiceClientData = {
                    'clientName': clientName,
                    'clientEmailAddress': clientEmailAddress,
                    'clientPhone': clientPhone.toString(),
                    'clientBillingAddress': clientBillingAddress,
                    'clientShippingAddress': clientShippingAddress,
                  };

                  ref.read(invoiceInfoProvider.notifier).getClientInfo(clientName,
                      clientEmailAddress, clientPhone , clientBillingAddress,
                      clientShippingAddress);

                  Navigator.pop(context, invoiceClientData);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
                child: Container(
                  height: 1400.0,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Client Name",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextFormField(
                              controller: _clientNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter client name',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the client name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Email Address",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextFormField(
                              controller: _clientEmailAddressController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter client email address',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                } else if (!RegExp(
                                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Phone",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextFormField(
                              controller: _clientPhoneController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter client phone number',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20.0),
                          // Create Date Field
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Billing Address",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextFormField(
                              controller: _clientBillingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter address line1',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the billing address';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20.0),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Shipping Address",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextFormField(
                              controller: _clientshippingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter address line1',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the shipping address';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
