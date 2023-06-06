import '../enums/enums.dart';

class Bill {
  final String id;
  final int? table;
  final String? customerName;
  final BillStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Bill({
    required this.id,
    this.table,
    this.customerName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}



class NewBill {
  final int? table;
  final String? customerName;
  const NewBill({
    this.table,
    this.customerName,
  });
}
