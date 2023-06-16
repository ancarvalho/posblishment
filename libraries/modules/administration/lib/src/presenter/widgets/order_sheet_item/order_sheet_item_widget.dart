import 'package:administration/src/presenter/widgets/order_sheet_item/order_sheet_item_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO change for index anfd get from store
class OrderSheetItemWidget extends StatefulWidget {
  const OrderSheetItemWidget({
    super.key,
    this.item = const NewItem(quantity: 1, productId: ""),
  });
  final NewItem item;

  @override
  State<OrderSheetItemWidget> createState() => _OrderSheetItemWidgetState();
}

class _OrderSheetItemWidgetState extends State<OrderSheetItemWidget> {
  final orderSheetItemController = OrderSheetItemController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: orderSheetItemController.formKey,
      child: Row(children: [
        CustomTextFormField(
          controller: orderSheetItemController.itemCodeController,
          decorationName: "Código",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          value: widget.item.code.toString(),
        ),
        CustomTextFormField(
          controller: orderSheetItemController.itemQuantityController,
          decorationName: "Quantidade",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          value: widget.item.quantity.toString(),
        ),
      ]),
    );
  }
}
