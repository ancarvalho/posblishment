import "package:core/core.dart";
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Product(name: "Peixada de Cavala", price: 25.59);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Flex(
            // mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              Text(product.id ?? ""),
              ListTile(
                title: Text(product.name),
                subtitle: Text(product.description ?? ""),
                leading: Text("R\$ ${product.price}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
