import 'package:flutter/material.dart';

IconData transformToIcon(String? name) {
  switch (name) {
    case "table_bar":
      return Icons.table_bar;
    case "delivery":
      return Icons.delivery_dining;

    default:
      return Icons.delivery_dining;
  }
}
