import 'package:administration/src/presenter/pages/order_sheet/make_request_store.dart';
import 'package:administration/src/presenter/pages/order_sheet/order_sheet_store.dart';
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
  // final _orderSheetStore = OrderSheetController();

  final ProductStore _productStore = Modular.get<ProductStore>();
  final MakeRequestStore _makeRequestStore = Modular.get<MakeRequestStore>();
  final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

  late Disposer _orderStoreListener;
  late Disposer _requestStoreListener;

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
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Comanda Virtual"),
          centerTitle: true,
        ),
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
                          width: Sizes.width(context) * .7,
                          child: TextFormField(
                            controller: _orderSheetStore.tableTextController,
                            keyboardType: TextInputType.number,
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
                              (e) => OrderSheetItemWidget(
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
                  OrderSheetItemWidget(
                      item: NewItem.empty(),
                      addItem: _orderSheetStore.insertItemONRequest),
                  // ..._orderSheetStore.state.items
                  //     .asMap()
                  //     .entries
                  //     .map(
                  //       (e) => OrderSheetItemWidget(
                  //         key: Key(e.key.toString()),
                  //         item: e.value,
                  //         index: e.key,
                  //         increaseORdecrease:
                  //             _orderSheetStore.increaseOrDecreaseQuantity,
                  //         removeItem: _orderSheetStore.removeItemInRequests,
                  //       ),
                  //     )
                  //     .toList(),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _requestStoreListener();
    _orderStoreListener();
    // _orderSheetStore.removeListener(() {});
  }
}
