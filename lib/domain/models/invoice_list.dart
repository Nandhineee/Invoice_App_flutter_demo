const String invoiceTableName = 'invoice';
const String invoiceId = 'invoiceId';
const String invoiceTableId = 'tableId';
const String invoiceCreateName = 'invoiceName';
const String invoicePrice = 'price';
const String invoicePaid = 'paid';
const String invoiceCreatedDate = 'createdDate';
const String invoiceDueDate = 'DueDate';
const String invoiceDueTerms = 'dueTerms';
const String invoiceBusinessName = 'businessName';
const String invoiceBusinessEmailAddress = 'businessEmailAddress';
const String invoiceBusinessPhone = 'businessPhone';
const String invoiceBusinessBillingAddress = 'businessBillingAddress';
const String invoiceBusinessWebsite = 'businessWebsite';
const String invoiceClientName = 'clientName';
const String invoiceClientEmailAddress = 'clientEmailAddress';
const String invoiceClientPhone = 'clientPhone';
const String invoiceClientBillingAddress = 'clientBillingAddress';
const String invoiceClientShippingAddress = 'clientShippingAddress';
const String invoiceDiscount = 'discount';
const String invoiceTax = 'tax';
const String invoiceShipping = 'shipping';

class Invoice {
  String id;
  int tableId;
  String invoiceName;
  String price;
  bool paid;
  DateTime? createdDate;
  DateTime? dueDate;
  String dueTerms;
  String businessName;
  String businessEmailAddress;
  int businessPhone;
  String businessBillingAddress;
  String businessWebsite;
  String clientName;
  String clientEmailAddress;
  int clientPhone;
  String clientBillingAddress;
  String clientShippingAddress;
  String discount;
  String tax;
  String shipping;

  Invoice(
      this.id,
      this.tableId,
      this.invoiceName,
      this.price,
      this.paid,
      this.createdDate,
      this.dueDate,
      this.dueTerms,
      this.businessName,
      this.businessEmailAddress,
      this.businessPhone,
      this.businessBillingAddress,
      this.businessWebsite,
      this.clientName,
      this.clientEmailAddress,
      this.clientBillingAddress,
      this.clientPhone,
      this.clientShippingAddress,
      this.discount,
      this.shipping,
      this.tax);

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      json['invoiceId'],
      json['tableId'],
      json['invoiceName'],
      json['price'],
      json['paid'] == 1 ? true : false,
      json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      json['DueDate'] != null ? DateTime.parse(json['DueDate']) : null,
      json['dueTerms'],
      json['businessName'],
      json['businessEmailAddress'],
      json['businessPhone'],
      json['businessBillingAddress'],
      json['businessWebsite'],
      json['clientName'],
      json['clientEmailAddress'],
      json['clientBillingAddress'],
      json['clientPhone'],
      json['clientShippingAddress'],
      json['discount'],
      json['shipping'],
      json['tax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoiceId': id,
      'invoiceName': invoiceName,
      'price': price,
      'paid': paid ? 1:0,
      'createdDate': createdDate?.toIso8601String(),
      'DueDate': dueDate?.toIso8601String(),
      'dueTerms': dueTerms,
      'businessName': businessName,
      'businessEmailAddress': businessEmailAddress,
      'businessPhone': businessPhone,
      'businessBillingAddress': businessBillingAddress,
      'businessWebsite': businessWebsite,
      'clientName': clientName,
      'clientEmailAddress': clientEmailAddress,
      'clientBillingAddress': clientBillingAddress,
      'clientPhone': clientPhone,
      'clientShippingAddress': clientShippingAddress,
      'discount': discount,
      'tax': tax,
      'shipping': shipping,
    };
  }
}

List<Invoice> invoice = [
  Invoice(
      'INV456',
      01,
      'Project Launch Invoice',
      '8999',
        true,
      DateTime.now(),
      DateTime(2024, 3, 1),
      // Due one month after creation
      'Net 30 Days',
      'Creative Solutions Inc.',
      'contact@creativesolutions.com',
      1122334455,
      '456 Innovation Drive, Tech Park',
      'www.creativesolutions.com',
      'Future Ventures',
      'info@futureventures.com',
      '789 Venture Blvd, Startup City',
      2233445566,
      '789 Venture Blvd, Startup City',
      '0',
      '20',
      '15'),
  Invoice(
    'INV789',
    02,
    'Consulting & Hardware Invoice',
    '6734',
    false,
    DateTime(2024, 5, 1),
    DateTime(2024, 6, 1),
    'Net 30 Days',
    'NextGen Innovations',
    'sales@nextgeninnovations.com',
    5566778899,
    '1010 Future Lane, Innovation City',
    'www.nextgeninnovations.com',
    'Tech Startups Inc.',
    'purchase@techstartups.com',
    '1234 Startup Street, Entrepreneur Town',
    9988776655,
    '1234 Startup Street, Entrepreneur Town',
    '0',
    '30',
    '10',
  ),
  Invoice(
    'INV003',
    03,
    'Web Hosting & Cybersecurity Invoice',
    '8901',
    false,
    DateTime(2024, 7, 15),
    DateTime(2024, 8, 15),
    'Net 30 Days',
    'CyberTech Solutions',
    'support@cybertechsolutions.com',
    1234567890,
    '500 Digital Way, Cyber City',
    'www.cybertechsolutions.com',
    'Global Enterprises Ltd.',
    'procurement@globalenterprises.com',
    '6789 Enterprise Avenue, Commerce City',
    9876543210,
    '6789 Enterprise Avenue, Commerce City',
    '100',
    '50',
    '12',
  ),
  Invoice(
    'INV004',
    04,
    'Marketing & Branding Services Invoice',
    '9022',
    true,
    DateTime(2024, 9, 1),
    DateTime(2024, 10, 1),
    'Net 30 Days',
    'Visionary Marketing Solutions',
    'contact@visionarymarketingsolutions.com',
    1122334455,
    '250 Branding Blvd, Market City',
    'www.visionarymarketingsolutions.com',
    'Innovative Retailers Inc.',
    'order@innovativeretailers.com',
    '3345 Shopping Plaza, Retail Town',
    9988776655,
    '3345 Shopping Plaza, Retail Town',
    '150',
    '75',
    '15',
  ),
];
