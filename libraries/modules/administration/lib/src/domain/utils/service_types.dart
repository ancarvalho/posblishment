import 'package:flutter/material.dart';

enum ServiceTypes {
  delivery(icon: Icons.delivery_dining, name: "Delivery"),
  table(icon: Icons.table_bar, name: "Mesa");

  const ServiceTypes({
    required this.icon,
    required this.name,
  });
  final IconData icon;
  final String name;
}
