import 'package:administration/src/presenter/widgets/order_sheet/order_sheet_store.dart';
import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:flutter_triple/flutter_triple.dart";

import '../../stores/request/make_request_store.dart';
import '../../widgets/order_sheet_item/order_sheet_add_item_widget.dart';
import '../../widgets/order_sheet_item/order_sheet_edit_item_widget.dart';

// Remember this could only be used with products using code
class OrderSheetWidget extends StatefulWidget {
  const OrderSheetWidget({super.key});

  @override
  State<OrderSheetWidget> createState() => _OrderSheetWidgetState();
}

class _OrderSheetWidgetState extends State<OrderSheetWidget> {
  // final _orderSheetStore = OrderSheetController();

  final ProductStore _productStore = Modular.get<ProductStore>();
  final MakeRequestStore _makeRequestStore = Modular.get<MakeRequestStore>();
  final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

  late Disposer _orderStoreListener;
  late Disposer _requestStoreListener;

  final FocusNode codeFieldFocusNode = FocusNode();
  final FocusNode quantityFieldFocusNode = FocusNode();

  @override
  void initState() {
    // Solution For now
    _requestStoreListener = _makeRequestStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onState: (req) {
        _orderSheetStore.clearRequest();
      },
    );

    _orderStoreListener = _orderSheetStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onLoading: (loading) => setState(() {}),
    );

    _productStore.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    

      body: ScopedBuilder<ProductStore, Failure, List<Product>>(
        store: _productStore,
        onState: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _orderSheetStore.formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: Sizes.width(context) * .3,
                        child: TextFormField(
                          autofocus: Sizes.isMobile(context),
                          controller: _orderSheetStore.tableTextController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (state) {
                            codeFieldFocusNode.requestFocus();
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration:
                              const InputDecoration(labelText: "Mesa"),
                        ),
                      ),
                    ],
                  ),
                ),
                ScopedBuilder<OrderSheetStore, Failure, NewRequest>(
                  store: _orderSheetStore,
                  onState: (context, state) {
                    return Column(
                      children: state.items
                          .asMap()
                          .entries
                          .map(
                            (e) => OrderSheetEditItemWidget(
                              key: Key(e.key.toString()),
                              item: e.value,
                              index: e.key,
                              increaseORdecrease:
                                  _orderSheetStore.increaseOrDecreaseQuantity,
                              removeItem:
                                  _orderSheetStore.removeItemInRequests,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                OrderSheetAddItemWidget(
                  // key: const Key("Const Key"),
                  addItem: _orderSheetStore.insertItemONRequest,
                  codeFieldFocusNode: codeFieldFocusNode,
                  quantityFieldFocusNode: quantityFieldFocusNode,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Enviar Pedido",
        // TODO Check here
        onPressed: _orderSheetStore.saveChanges,
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _requestStoreListener();
    _orderStoreListener();
    codeFieldFocusNode.dispose();
    quantityFieldFocusNode.dispose();
    // _orderSheetStore.removeListener(() {});
  }
}
