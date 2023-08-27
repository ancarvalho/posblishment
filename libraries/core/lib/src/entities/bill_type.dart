import 'package:core/core.dart';

class BillType {
  final String id;
  final String name;
  final String? icon;
  final double? value;
  final BillTypes type;
  final bool? defaultType;

  const BillType({
    required this.id,
    required this.name,
    required this.type,
    this.value,
    this.icon,
    this.defaultType,
  });

  // factory BillType.empty() {
  //   return const BillType(id: "", name: "", type: BillTypes.percentageTax);
  // }
}

class NewBillType {
  final String name;
  final String? icon;
  final double? value;
  final BillTypes type;
  final bool? defaultType;
  const NewBillType({
    required this.name,
    required this.type,
    this.value,
    this.icon,
    this.defaultType,
  });

  // factory NewBillType.empty() {
  //   return const NewBillType(name: "", type: BillTypes.percentageTax);
  // }
}
