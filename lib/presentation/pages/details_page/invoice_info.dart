import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:invoice/presentation/providers/invoice_info_provider.dart';

class InvoiceInfo extends ConsumerStatefulWidget {
  const InvoiceInfo(
      {super.key,
      required this.invoiceId,
      required this.invoiceName,
      required this.createdDate,
      required this.dueDate,
      required this.dueTerms});

  final String invoiceId;
  final String invoiceName;
  final DateTime createdDate;
  final DateTime dueDate;
  final String dueTerms;

  @override
  ConsumerState<InvoiceInfo> createState() => _InvoiceInfoState();
}

class _InvoiceInfoState extends ConsumerState<InvoiceInfo> {
  late String invoiceId;
  late String invoiceName;
  late DateTime createdDate;
  late DateTime dueDate;
  late String dueTerms;

  @override
  void initState() {
    super.initState();
    invoiceId = widget.invoiceId;
    invoiceName = widget.invoiceName;
    createdDate = widget.createdDate;
    dueDate = widget.dueDate;
    dueTerms = widget.dueTerms;
  }

  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  DateTime _endedDate = DateTime.now();

  String get getDate {
    return DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  String get endedDate{
    return DateFormat('yyyy-MM-dd').format(_endedDate);
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _duedatecontroller = TextEditingController();
  final TextEditingController _duecontroller = TextEditingController();
  final TextEditingController _invoiceTitleController = TextEditingController();

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
              "Invoice Info",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String invoiceId = _controller.text;
                  DateTime createdDate = DateTime.parse(_dateController.text);
                  DateTime dueDate = DateTime.parse(_duedatecontroller.text);
                  String dueTerms = _duecontroller.text;
                  String invoiceName = _invoiceTitleController.text;

                  Map<String, String> invoiceData = {
                    'invoiceId': invoiceId,
                    'createdDate': createdDate.toIso8601String(),
                    'dueDate': dueDate.toIso8601String(),
                    'dueTerms': dueTerms,
                    'invoiceName': invoiceName,
                  };
                  ref.read(invoiceInfoProvider.notifier).getInvoiceInfo(invoiceId,invoiceName,
                      createdDate,dueDate,
                      dueTerms);
                  Navigator.pop(context, invoiceData);
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
                  height: 700.0,
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
                                  text: "Invoice Number",
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
                              controller: _controller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the invoice number';
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
                                  text: "Creation Date",
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Select date",
                                      border: InputBorder.none,
                                    ),
                                    controller: _dateController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () => openDatePicker()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Due Terms",
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
                              controller: _duecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the invoice number';
                                } else if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid number';
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
                                  text: "Due Date",
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Select date",
                                      border: InputBorder.none,
                                    ),
                                    controller: _duedatecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () => endDatePicker()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Invoice Title Name",
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
                              controller: _invoiceTitleController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'INVOICE',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an invoice title';
                                }
                                return null;
                              },
                            ),
                          ),
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

  Future<void> openDatePicker() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,

        firstDate: DateTime(2010, 4, 1),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _dateController.text = getDate;
      });
    }
  }

  Future<void> endDatePicker() async {
    final endDate = await showDatePicker(
        context: context,
        initialDate: _endedDate,

        firstDate: _selectedDate,
        lastDate: DateTime(2025, 12, 30));

    if (endDate != null) {
      setState(() {
        _endedDate = endDate;
        _duedatecontroller.text = endedDate;
      });
    }
  }
}
