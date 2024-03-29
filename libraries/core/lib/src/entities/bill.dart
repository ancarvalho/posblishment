import 'package:core/src/entities/bill_type.dart';

import '../enums/enums.dart';

class Bill {
  final String id;
  final int? table;
  final String? customerName;
  final BillStatus status;
  final String billTypeId;
  final BillType? billType;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Bill( {
    required this.id,
    this.table,
    this.customerName,
    this.billType,
    required this.status,
    required this.createdAt,
    required this.billTypeId,
    this.updatedAt,
  });

  factory Bill.empty() =>
      Bill(id: "", status: BillStatus.open, createdAt: DateTime.now(), billTypeId: "");
}

class NewBill {
  final int? table;
  final String? customerName;
  final String? billTypeID;
  const NewBill({
    this.table,
    this.customerName,
    this.billTypeID,
  });
}
