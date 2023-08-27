import 'package:administration/src/presenter/pages/order_sheet/order_sheet_controller.dart';
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
  final _orderSheetController = OrderSheetController();

  final ProductStore _productStore = Modular.get<ProductStore>();
  final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

  late Disposer _orderStoreListener;

  @override
  void initState() {
    // Solution For now
    _orderStoreListener = _orderSheetStore.observer(
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
      onState: (req) {
        _orderSheetController.clearRequest();
      },
    );
    _orderSheetController.addListener(() {
      setState(() {});
    });

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
                    key: _orderSheetController.formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: Sizes.width(context) * .7,
                          child: TextFormField(
                            controller:
                                _orderSheetController.tableTextController,
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
                  ..._orderSheetController.request.items
                      .asMap()
                      .entries
                      .map(
                        (e) => OrderSheetItemWidget(
                          key: Key(e.key.toString()),
                          item: e.value,
                          index: e.key,
                          increaseORdecrease:
                              _orderSheetController.increaseOrDecreaseQuantity,
                          removeItem: _orderSheetController.removeItemInRequest,
                        ),
                      )
                      .toList(),
                  OrderSheetItemWidget(
                    item: NewItem.empty(),
                    addItem: _orderSheetController.insertItemONRequest,
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () {
            _orderSheetController.saveChanges().then((value) => value.fold(
                (l) => displayMessageOnSnackbar(context, l.errorMessage),
                (r) => null,),);
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _orderSheetController.dispose();
    _orderStoreListener();
    // _orderSheetController.removeListener(() {});
  }
}
