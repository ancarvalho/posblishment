import 'package:core/core.dart';
import 'package:flutter/material.dart';

enum PaymentTypes {
  creditCard(
    name: "credit card",
    icon: Icons.credit_card,
    value: PaymentType.creditCard,
  ),
  debitCard(
    name: "debit",
    icon: Icons.credit_card,
    value: PaymentType.debitCard,
  ),
  pix(
    name: "pix",
    icon: Icons.pix,
    value: PaymentType.pix,
  ),
  cash(
    name: "cash",
    icon: Icons.payments_outlined,
    value: PaymentType.cash,
  );

  const PaymentTypes({
    required this.name,
    required this.icon,
    required this.value,
  });

  final String name;
  final IconData icon;
  final PaymentType value;
}
