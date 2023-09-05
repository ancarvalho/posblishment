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
    this.index,
    this.removeItem,
    this.increaseORdecrease,
  });

  final NewItem item;
  final void Function(NewItem? item)? addItem;
  final Function(int index)? removeItem;
  final void Function(IncreaseORDecrease e, int index)? increaseORdecrease;
  final int? index;

  @override
  State<OrderSheetItemWidget> createState() => _OrderSheetItemWidgetState();
}

class _OrderSheetItemWidgetState extends State<OrderSheetItemWidget> {
  final orderSheetItemController = OrderSheetItemController();

  @override
  void initState() {
    orderSheetItemController.resetFields(widget.item);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: orderSheetItemController.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: CustomTextFormField(
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (state) {
                if (widget.index == null) {
                  widget.addItem!(orderSheetItemController.transformToItem());
                  orderSheetItemController.clearFields();
                }
              },
              controller: orderSheetItemController.itemCodeController,
              decorationName: "Código",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              enabled: widget.index == null,
              value: widget.item.code?.toString(),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SizedBox(
            width: 40,
            child: CustomTextFormField(
              controller: orderSheetItemController.itemQuantityController,
              decorationName: "Quantidade",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              value: widget.item.quantity.toString(),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SizedBox(
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: widget.index != null
                      ? () {
                          widget.increaseORdecrease!(
                            IncreaseORDecrease.increase,
                            widget.index!,
                          );
                         
                        }
                      : orderSheetItemController.increaseQuantity,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 30,
                    // size:
                  ),
                ),
                TextButton(
                  onPressed: widget.index != null
                      ? () => widget.increaseORdecrease!(
                            IncreaseORDecrease.decrease,
                            widget.index!,
                          )
                      : orderSheetItemController.decreaseQuantity,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(30, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                    // size:
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
            child: IconButton(
              onPressed: widget.index != null
                  ? () {
                      widget.removeItem!(widget.index!);
                    }
                  : () {
                      widget
                          .addItem!(orderSheetItemController.transformToItem());
                      orderSheetItemController.clearFields();
                    },
              icon: widget.index != null
                  ? const Icon(Icons.remove)
                  : const Icon(Icons.add),
              tooltip: widget.index != null ? "Add Item" : "Remove Item",
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    orderSheetItemController.dispose();
    super.dispose();
  }
}
