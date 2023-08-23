import 'package:administration/src/presenter/pages/order_sheet/order_sheet_controller.dart';
import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:administration/src/presenter/widgets/order_sheet_item/order_sheet_item_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:flutter_triple/flutter_triple.dart";

// Remember this could only be used with products using code
class OrderSheetPage extends StatefulWidget {
  const OrderSheetPage({super.key});

  @override
  State<OrderSheetPage> createState() => _OrderSheetPageState();
}

class _OrderSheetPageState extends State<OrderSheetPage> {
  final OrderSheetController _orderSheetController = OrderSheetController();

  final ProductStore _productStore = Modular.get<ProductStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comanda Virtual"),
        centerTitle: true,
      ),
      body: ScopedBuilder<ProductStore, Failure, List<Product>>(
        store: _productStore,
        onState: (context, state) {
          return Column(
            children: [
              Form(
                key: _orderSheetController.formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: Sizes.width(context) * .7,
                      child: TextFormField(
                        controller: _orderSheetController.tableTextController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(labelText: "Mesa"),
                      ),
                    ),
                  ],
                ),
              ),
              ..._orderSheetController.request.value.items
                  .map((e) => OrderSheetItemWidget(item: e))
                  .toList(),
              OrderSheetItemWidget(item: NewItem.empty())
            ],
          );
        },
      ),
    );
  }
}
