import 'dart:ui';

import 'package:core/core.dart';

Color transformBillStatusIntoColor(BillStatus billStatus) {
  switch (billStatus) {
    case BillStatus.open:
      return const Color.fromARGB(255, 19, 115, 2);
    case BillStatus.closed:
      return const Color.fromARGB(255, 255, 6, 10);
    case BillStatus.paid:
      return const Color.fromARGB(255, 1, 30, 252);
    case BillStatus.paidWithoutCommission:
      return const Color.fromARGB(255, 0, 97, 253);
    case BillStatus.canceled:
      return const Color.fromARGB(255, 252, 1, 131);
    case BillStatus.partiallyPaid:
      return const Color.fromARGB(255, 252, 89, 1);
  }
}
