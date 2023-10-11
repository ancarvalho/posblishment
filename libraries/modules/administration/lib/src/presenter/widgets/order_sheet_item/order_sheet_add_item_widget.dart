import 'package:administration/src/presenter/widgets/order_sheet_item/order_sheet_item_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO change for index anfd get from store
class OrderSheetAddItemWidget extends StatefulWidget {
  const OrderSheetAddItemWidget({
    super.key,
    required this.addItem, required this.codeFieldFocusNode, required this.quantityFieldFocusNode,
  });

  final void Function(NewItem? item) addItem;
  final FocusNode codeFieldFocusNode;
  final FocusNode quantityFieldFocusNode;

  @override
  State<OrderSheetAddItemWidget> createState() =>
      _OrderSheetAddItemWidgetState();
}

class _OrderSheetAddItemWidgetState extends State<OrderSheetAddItemWidget> {
  final orderSheetItemController = OrderSheetItemController();
  // final FocusNode codeFieldFocusNode = FocusNode();
  // final FocusNode quantityFieldFocusNode = FocusNode();

  @override
  void initState() {
    orderSheetItemController.resetFields(NewItem.empty());
    // codeFieldFocusNode.requestFocus();
    super.initState();
  }

  void sendAndClear() {
    widget.addItem(orderSheetItemController.transformToItem());
    orderSheetItemController.clearFields();
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
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (state) {
                // codeFieldFocusNode.unfocus();
                // FocusScope.of(context).requestFocus(quantityFieldFocusNode);
                widget.quantityFieldFocusNode.requestFocus();
                // sendAndClear();
              },
              controller: orderSheetItemController.itemCodeController,
              decorationName: "Código",
              keyboardType: TextInputType.number,
              focusNode: widget.codeFieldFocusNode,
              // autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              value: orderSheetItemController.itemCodeController.text,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SizedBox(
            width: 40,
            child: CustomTextFormField(
              controller: orderSheetItemController.itemQuantityController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (state) {
                sendAndClear();
                widget.codeFieldFocusNode.requestFocus();
              },
              decorationName: "Quantidade",
              focusNode: widget.quantityFieldFocusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              value: orderSheetItemController.itemQuantityController.text,
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
                  onPressed: orderSheetItemController.increaseQuantity,
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
                  onPressed: orderSheetItemController.decreaseQuantity,
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
              onPressed: sendAndClear,
              icon: const Icon(Icons.add),
              tooltip: "Add Item",
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    orderSheetItemController.dispose();
    // codeFieldFocusNode.dispose();
    // quantityFieldFocusNode.dispose();
    super.dispose();
  }
}
