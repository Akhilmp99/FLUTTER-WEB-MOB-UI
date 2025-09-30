// bill_model.dart
class WeighmentTicket {
  final String id;
  final String ticketNumber;
  final DateTime date;
  final String vehicleNumber;
  final String driverName;
  final String product;
  final String customer;
  final String customerGstin;
  final String customerAddress;
  final double grossWeight;
  final double tareWeight;
  final double netWeight;
  final String source;
  final String destination;
  final DateTime inTime;
  final DateTime outTime;
  final String status;
  final double ratePerTon;
  final double freightCharges;
  final double otherCharges;
  final String remarks;

  WeighmentTicket({
    required this.id,
    required this.ticketNumber,
    required this.date,
    required this.vehicleNumber,
    required this.driverName,
    required this.product,
    required this.customer,
    required this.customerGstin,
    required this.customerAddress,
    required this.grossWeight,
    required this.tareWeight,
    required this.netWeight,
    required this.source,
    required this.destination,
    required this.inTime,
    required this.outTime,
    required this.status,
    required this.ratePerTon,
    required this.freightCharges,
    required this.otherCharges,
    required this.remarks,
  });

  double get totalAmount => (netWeight * ratePerTon) + freightCharges + otherCharges;
  double get taxAmount => totalAmount * 0.18; // 18% GST
  double get grandTotal => totalAmount + taxAmount;

  factory WeighmentTicket.fromJson(Map<String, dynamic> json) {
    return WeighmentTicket(
      id: json['id'],
      ticketNumber: json['ticketNumber'],
      date: DateTime.parse(json['date']),
      vehicleNumber: json['vehicleNumber'],
      driverName: json['driverName'],
      product: json['product'],
      customer: json['customer'],
      customerGstin: json['customerGstin'],
      customerAddress: json['customerAddress'],
      grossWeight: (json['grossWeight'] as num).toDouble(),
      tareWeight: (json['tareWeight'] as num).toDouble(),
      netWeight: (json['netWeight'] as num).toDouble(),
      source: json['source'],
      destination: json['destination'],
      inTime: DateTime.parse(json['inTime']),
      outTime: DateTime.parse(json['outTime']),
      status: json['status'],
      ratePerTon: (json['ratePerTon'] as num).toDouble(),
      freightCharges: (json['freightCharges'] as num).toDouble(),
      otherCharges: (json['otherCharges'] as num).toDouble(),
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketNumber': ticketNumber,
      'date': date.toIso8601String(),
      'vehicleNumber': vehicleNumber,
      'driverName': driverName,
      'product': product,
      'customer': customer,
      'customerGstin': customerGstin,
      'customerAddress': customerAddress,
      'grossWeight': grossWeight,
      'tareWeight': tareWeight,
      'netWeight': netWeight,
      'source': source,
      'destination': destination,
      'inTime': inTime.toIso8601String(),
      'outTime': outTime.toIso8601String(),
      'status': status,
      'ratePerTon': ratePerTon,
      'freightCharges': freightCharges,
      'otherCharges': otherCharges,
      'remarks': remarks,
    };
  }
}

class Invoice {
  final String id;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final WeighmentTicket ticket;
  final double taxRate;
  final String status;
  final DateTime? paymentDate;
  final String paymentMode;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.ticket,
    required this.taxRate,
    required this.status,
    this.paymentDate,
    required this.paymentMode,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoiceNumber'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      ticket: WeighmentTicket.fromJson(json['ticket']),
      taxRate: (json['taxRate'] as num).toDouble(),
      status: json['status'],
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
      paymentMode: json['paymentMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate.toIso8601String(),
      'ticket': ticket.toJson(),
      'taxRate': taxRate,
      'status': status,
      'paymentDate': paymentDate?.toIso8601String(),
      'paymentMode': paymentMode,
    };
  }
}

class BillData {
  static List<WeighmentTicket> getPendingWeighmentTickets() {
    return [
      WeighmentTicket(
        id: '1',
        ticketNumber: 'WT00124',
        date: DateTime(2024, 3, 15),
        vehicleNumber: 'MH12AB1234',
        driverName: 'Sanjay Kumar',
        product: '20mm Aggregate',
        customer: 'Tech Solutions Inc.',
        customerGstin: '29AABCU9603R1ZM',
        customerAddress: '123 Business Park, Mumbai, Maharashtra 400001',
        grossWeight: 25.5,
        tareWeight: 8.2,
        netWeight: 17.3,
        source: 'ABC Quarry',
        destination: 'Tech Solutions Site',
        inTime: DateTime(2024, 3, 15, 8, 30),
        outTime: DateTime(2024, 3, 15, 10, 15),
        status: 'Completed',
        ratePerTon: 850.0,
        freightCharges: 1500.0,
        otherCharges: 500.0,
        remarks: 'Good quality material',
      ),
      WeighmentTicket(
        id: '2',
        ticketNumber: 'WT00125',
        date: DateTime(2024, 3, 15),
        vehicleNumber: 'MH14CD5678',
        driverName: 'Vikram Singh',
        product: 'River Sand',
        customer: 'Global Enterprises Ltd.',
        customerGstin: '07ABACS4307B1Z9',
        customerAddress: '456 Corporate Tower, Delhi, NCR 110001',
        grossWeight: 28.2,
        tareWeight: 9.1,
        netWeight: 19.1,
        source: 'River Sand Depot',
        destination: 'Global Enterprises Site',
        inTime: DateTime(2024, 3, 15, 9, 15),
        outTime: DateTime(2024, 3, 15, 11, 30),
        status: 'Completed',
        ratePerTon: 1200.0,
        freightCharges: 1800.0,
        otherCharges: 600.0,
        remarks: 'Fine quality sand',
      ),
      WeighmentTicket(
        id: '3',
        ticketNumber: 'WT00126',
        date: DateTime(2024, 3, 16),
        vehicleNumber: 'GJ05EF9012',
        driverName: 'Ramesh Patel',
        product: 'GSB',
        customer: 'Patel Carriers',
        customerGstin: '24AADCI1205H1ZP',
        customerAddress: '789 Industrial Area, Ahmedabad, Gujarat 380001',
        grossWeight: 30.1,
        tareWeight: 10.2,
        netWeight: 19.9,
        source: 'GSB Plant',
        destination: 'Highway Project',
        inTime: DateTime(2024, 3, 16, 7, 45),
        outTime: DateTime(2024, 3, 16, 9, 30),
        status: 'Completed',
        ratePerTon: 650.0,
        freightCharges: 2000.0,
        otherCharges: 450.0,
        remarks: 'For road construction',
      ),
    ];
  }

  static List<Invoice> getGeneratedInvoices() {
    final tickets = getPendingWeighmentTickets();
    return [
      Invoice(
        id: '1',
        invoiceNumber: 'INV001',
        invoiceDate: DateTime(2024, 3, 16),
        ticket: tickets[0],
        taxRate: 18.0,
        status: 'Paid',
        paymentDate: DateTime(2024, 3, 20),
        paymentMode: 'Bank Transfer',
      ),
      Invoice(
        id: '2',
        invoiceNumber: 'INV002',
        invoiceDate: DateTime(2024, 3, 16),
        ticket: tickets[1],
        taxRate: 18.0,
        status: 'Pending',
        paymentDate: null,
        paymentMode: 'Cash',
      ),
    ];
  }

  static List<String> getPaymentModes() {
    return ['Cash', 'Bank Transfer', 'UPI', 'Cheque', 'Credit Card'];
  }

  static List<String> getTaxRates() {
    return ['5%', '12%', '18%', '28%'];
  }
}