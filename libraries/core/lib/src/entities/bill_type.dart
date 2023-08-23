import 'package:core/core.dart';

class BillType {
  final String id;
  final String name;
  final String? icon;
  final BillTypes type;

  const BillType({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
  });
}
