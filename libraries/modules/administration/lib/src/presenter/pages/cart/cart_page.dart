import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../widgets/cart/cart_card_widget.dart';
import 'cart_store.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartStore = Modular.get<CartStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
        centerTitle: true,
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
                          item: state.values.elementAt(index));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cartStore.saveChanges,
        child: const Icon(Icons.send),
      ),
    );
  }
}
