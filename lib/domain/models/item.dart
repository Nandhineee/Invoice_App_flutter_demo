const String itemTableName = 'item';
const String itemInvoiceId = 'invoiceId';
const String itemId = 'id';
const String itemName = 'name';
const String itemPrice = 'price';
const String itemQuantity = 'quantity';
const String itemDiscount = 'discount';
const String itemTax = 'tax';

class Item {
  String invoiceId;
  num id;
  String name;
  num price;
  num quantity;
  num discount;
  num tax;

  Item(this.invoiceId, this.id, this.name, this.quantity, this.price,
      this.discount, this.tax);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['invoiceId'],
      json['id'],
      json['name'].toString(),
      json['quantity'],
      json['price'],
      json['discount'],
      json['tax'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'invoiceId': invoiceId,
      // 'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'tax': tax,
    };
  }
}

List<Item> item = [
  Item(
    "INV456",
    1,
    'Laptop',
    999,
    50,
    90,
    0.2,
  ),
  Item(
    'INV789',
    2,
    'Smartphone',
    899.9,
    30,
    80,
    0.15,
  ),

  Item(
    'INV003',
    2,
    'Smartphone',
    788.00,
    50,
    79,
    0.15,
  ),

  Item(
    'INV004',
    2,
    'Smartphone',
    389.99,
    20,
    38,
    0.15,
  )
];
