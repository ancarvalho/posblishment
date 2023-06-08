import '../enums/enums.dart';

class Bill {
  final String id;
  final int? table;
  final String? customerName;
  final BillStatus status;
  final String billTypeID;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Bill( {
    required this.id,
    this.table,
    this.customerName,
    required this.billTypeID,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}

class NewBill {
  final int? table;
  final String? customerName;
  final String billTypeID;
  const NewBill({
    this.table,
    this.customerName,
    required this.billTypeID,
  });
}
