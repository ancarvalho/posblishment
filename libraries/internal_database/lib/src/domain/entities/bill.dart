enum BillStatus {
  open,
  closed,
  paid,
  paidWithoutCommission,
  canceled,
}

// // TODO define bill service taxes and extra, like delivery
// enum BillType {
//   takeout,
//   saloon,
//   delivery,
// }

// // three fields predefined, tax of service(shipping, waiter fee), (discount), (no tax) -> personalized tax (percentage or fixed)
// enum BillServiceType {
//   fixedBillTax, // a fixed percentage of bill total value
//   fixedTax, // fixed value
//   billDiscount, // a fixed percentage of bill total value
//   discount, // fixed value
//   dynamicTax,
//   dynamicBillTax,
// }

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
