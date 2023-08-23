import 'package:administration/src/domain/utils/utils.dart';
import 'package:administration/src/presenter/widgets/order_sheet_item/order_sheet_item_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO change for index anfd get from store
class OrderSheetItemWidget extends StatefulWidget {
  const OrderSheetItemWidget({
    super.key,
    required this.item,
    this.addItem,
    this.index = -1,
    this.removeItem,
    this.increaseORdecrease,
  });
  final NewItem item;

  final Function(NewItem? item)? addItem;
  final Function(int index)? removeItem;
  final Function(IncreaseORDecrease e, int index)? increaseORdecrease;
  final int index;

  @override
  State<OrderSheetItemWidget> createState() => _OrderSheetItemWidgetState();
}

class _OrderSheetItemWidgetState extends State<OrderSheetItemWidget> {
  final orderSheetItemController = OrderSheetItemController();
  bool isAlreadyAdded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index == -1) isAlreadyAdded = true;
    return Form(
      key: orderSheetItemController.formKey,
      child: Row(
        children: [
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
          Row(
            children: [
              TextButton(
                onPressed: () => isAlreadyAdded
                    ? widget.increaseORdecrease!(
                        IncreaseORDecrease.increase,
                        widget.index,
                      )
                    : orderSheetItemController.increaseQuantity(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(30, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  // size:
                ),
              ),
              TextButton(
                onPressed: () => isAlreadyAdded
                    ? widget.increaseORdecrease!(
                        IncreaseORDecrease.decrease, widget.index)
                    : orderSheetItemController.decreaseQuantity(),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  // size:
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: isAlreadyAdded
                ? widget.removeItem!(widget.index)
                : widget.addItem!(orderSheetItemController.transformToItem()),
            icon: isAlreadyAdded
                ? const Icon(Icons.remove)
                : const Icon(Icons.plus_one),
            label: Text(isAlreadyAdded ? "Add Item" : "Remove Item"),
          )
        ],
      ),
    );
  }
}
