import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../stores/request/make_request_store.dart';
import '../../widgets/cart/cart_card_widget.dart';
import 'cart_store.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartStore = Modular.get<CartStore>();

  late final Disposer _cartStoreDisposer;
  final MakeRequestStore _makeRequestStore = Modular.get<MakeRequestStore>();

  @override
  void initState() {
    _cartStoreDisposer = cartStore.observer(
      onLoading: (loading) => setState(() {}),
      onState: (state) {
        Navigator.of(context).canPop()
            ? Navigator.of(context).pop()
            : const DoNothingAndStopPropagationIntent();
      },
    );
    super.initState();
  }

  void handleRequest() {
    if (!_makeRequestStore.isLoading) {
      cartStore.saveChanges();
      return displayMessageOnSnackbar(context, "Pedido esta sendo Criado");
    }
    displayMessageOnSnackbar(context, "Pedido esta sendo Processado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: cartStore.clearRequest,
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: ScopedBuilder<CartStore, Failure, Map<String, NewItem>>(
        store: cartStore,
        onState: (context, state) {
          return Padding(
            padding: Paddings.paddingLTRB4(),
            child: Column(
              children: [
                Form(
                  key: cartStore.formKey,
                  child: SizedBox(
                    height: 80,
                    width: Sizes.width(context) * .7,
                    child: TextFormField(
                      controller: cartStore.tableTextController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(labelText: "Mesa"),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return CartCardWidget(
                        item: state.values.elementAt(index),
                        decreaseQuantity: cartStore.decreaseItemQuantity,
                        increaseQuantity: cartStore.increaseItemQuantity,
                        removeItem: cartStore.removeItemInRequests,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleRequest,
        child: const Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    _cartStoreDisposer();
    super.dispose();
  }
}
