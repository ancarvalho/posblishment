import 'package:core/core.dart';
import 'package:flutter/material.dart';

IconData transformToIcon(BillTypes billTypes) {
  switch (billTypes) {
    case BillTypes.percentageTax:
      return Icons.percent;
    case BillTypes.fixedTax:
      return Icons.lock;
    case BillTypes.withoutTax:
      return Icons.clear;
  }
}
