import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/presentation/providers/invoice_info_provider.dart';


class BusinessInfo extends ConsumerStatefulWidget {
  const BusinessInfo({super.key, required this.businessName, required this.businessEmailAddress, required this.businessPhone, required this.businessBillingAddress, required this.businessWebsite});

  final String businessName;
  final String businessEmailAddress;
  final num businessPhone;
  final String businessBillingAddress;
 final  String businessWebsite;

  @override
  ConsumerState<BusinessInfo> createState() => _BusinessInfoState();

}

class _BusinessInfoState extends ConsumerState<BusinessInfo> {
  late String businessName;
  late String businessEmailAddress;
  late num businessPhone;
  late String businessBillingAddress;
  late  String businessWebsite;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessEmailController = TextEditingController();
  final TextEditingController _businessPhoneController = TextEditingController();
  final TextEditingController _businessBillingController = TextEditingController();
  final TextEditingController _businessWebsiteController = TextEditingController();



  @override
  void initState() {
    super.initState();
    businessName=widget.businessName;
    businessEmailAddress=widget.businessEmailAddress;
    businessPhone=widget.businessPhone;
    businessBillingAddress=widget.businessBillingAddress;
    businessWebsite=widget.businessWebsite;
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
              "Business Info",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState!.validate()) {


                  String businessName = _businessNameController.text;
                   String businessEmailAddress= _businessEmailController.text;
                 String businessPhone = _businessPhoneController.text ;
                 String  businessBillingAddress = _businessBillingController.text;
                  String businessWebsite = _businessWebsiteController.text;

                  Map<String, dynamic> invoiceBusinessData = {
                    'businessName': businessName,
                    'businessEmailAddress': businessEmailAddress,
                    'businessPhone': businessPhone,
                    'businessBillingAddress': businessBillingAddress,
                    'businessWebsite': businessWebsite,
                  };
                  ref.read(invoiceInfoProvider.notifier).getBusinessInfo(businessName,businessEmailAddress,
                      businessPhone  ,businessBillingAddress,businessWebsite);
                  Navigator.pop(context, invoiceBusinessData);
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
                padding: const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
                child: Container(
                  height: 1000.0, // Adjust container height as needed
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
                                  text: "Business Name",
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter business name',
                              ),
                              controller:_businessNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the business name';
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

                              controller:_businessEmailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter business email address',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Enter a valid email address';
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

                              controller:_businessPhoneController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter business phone number',
                              ),
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
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

                              controller:_businessBillingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter address line',
                              ),
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
                                  text: "Business Website",
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

                              controller:_businessWebsiteController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter business website',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the business website';
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
        )

    );
  }
}
