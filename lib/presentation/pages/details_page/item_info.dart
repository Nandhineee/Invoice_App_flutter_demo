import 'package:flutter/material.dart';

class ItemInfo extends StatefulWidget {
  const ItemInfo(
      {super.key,
      required this.itemId,
      required this.itemName,
        required this.itemPrice,
      required this.quantity,
        required this.itemDiscount,
      required this.itemTax});

  final num itemId;
  final String itemName;
  final num itemPrice;
  final num quantity;
  final num itemDiscount;
  final num itemTax;

  @override
  State<ItemInfo> createState() => ItemInfoState();
}

class ItemInfoState extends State<ItemInfo> {
  final _formKey = GlobalKey<FormState>();

  late num itemId;
  late String itemName;
  late num itemPrice;
  late num quantity;
  late num itemDiscount;
  late num itemTax;

  @override
  void initState() {
    super.initState();
    itemId = widget.itemId;
    itemName = widget.itemName;
    quantity = widget.quantity;
    itemPrice = widget.itemPrice;
    itemTax = widget.itemTax;
    itemDiscount = widget.itemDiscount;
  }

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDiscountController = TextEditingController();

  final TextEditingController _itemTaxController = TextEditingController();

  final TextEditingController _itemQuantityController = TextEditingController();

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
              "New Item",
              style: TextStyle(fontSize: 30.0, color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Check if form is valid
                if (_formKey.currentState!.validate()) {
                  String itemName = _itemNameController.text;
                  String itemPrice = _itemPriceController.text;
                  String itemTax = _itemTaxController.text;
                  String itemDiscount = _itemDiscountController.text;
                  String quantity = _itemQuantityController.text;

                  Map<String, dynamic> invoiceItemData = {
                    'itemName': itemName,
                    'itemPrice': itemPrice.toString(),
                    'itemTax': itemTax.toString(),
                    'itemDiscount': itemDiscount.toString(),
                    'quantity': quantity.toString(),
                  };

                  Navigator.pop(context, invoiceItemData);
                  setState(() {

                  });
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
                  height: 1400.0, // Adjust container height as needed
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
                          // Invoice Number Field with Text and Star Symbol
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Item Name",
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
                              controller: _itemNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter item name',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the item name';
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
                                  text: "Item Price",
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
                              controller: _itemPriceController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "₹0.00",
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the item price';
                                } else if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid price';
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
                                  text: "Item Quantity",
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
                              controller: _itemQuantityController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '1',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the item quantity';
                                } else if (int.tryParse(value) == null ||
                                    int.parse(value) <= 0) {
                                  return 'Quantity must be greater than zero';
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
                                  text: "Discount",
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
                              controller: _itemDiscountController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                              ),
                              style: const TextStyle(fontSize: 16.0),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the discount';
                                } else if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid discount';
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
                                  text: "Tax Rate",
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
                                controller: _itemTaxController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0%',
                                ),
                                style: const TextStyle(fontSize: 16.0),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the tax rate';
                                  } else if (!RegExp(r'^\d+(\.\d{1,2})?$')
                                      .hasMatch(value)) {
                                    return 'Enter a valid tax rate';
                                  }
                                  return null;
                                }),
                          ),


                          const SizedBox(height: 20.0),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Item Description",
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
                            width: 500,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Stack(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 50.0,
                                        bottom: 30.0,
                                        right: 8.0,
                                        left: 8.0),
                                  ),
                                  style: const TextStyle(fontSize: 16.0),
                                  maxLines: null,
                                  // Adjust maxLines as needed
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the item description';
                                    } else if (value.length > 500) {
                                      return 'Description cannot exceed 500 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Text(
                                    '0/500',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
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
}
