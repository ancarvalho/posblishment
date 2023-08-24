import 'package:administration/src/presenter/pages/payment/payment_controller.dart';
import 'package:administration/src/presenter/pages/payment/payment_store.dart';
import 'package:administration/src/presenter/widgets/payment/payment_item_widget.dart';
import 'package:administration/src/presenter/widgets/payment/payment_text_field_with_buttons_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/payment/payment_floating_widget.dart';
import '../../widgets/payment/payment_methods_widget.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.billID});
  final String billID;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  final PaymentStore _paymentStore = Modular.get<PaymentStore>();
  final PaymentController _paymentController = PaymentController();

  @override
  void initState() {
    _paymentStore.getBillTotal(widget.billID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<PaymentStore, Failure, BillTotal>(
      store: _paymentStore,
      onState: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Pagamento"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                PaymentMethodsWidget(
                  paymentType: _paymentController.currentPaymentType,
                  selectPaymentType: _paymentController.setCurrentPaymentType,
                ),
                Form(
                  key: _paymentController.formKey,
                  child: PaymentTextFieldWithButtons(
                    textEditingController: _paymentController.valueController,
                    addSubtotalRemaining:
                        _paymentController.addValueWithoutCommission,
                    addHalfTotal: _paymentController.addHalfTotal,
                    addTotalRemaining: _paymentController.addRemainingValue,
                    addPaymentMethod: _paymentController.addValueToPayment,
                  ),
                ),
                ListView.builder(
                  itemCount: _paymentController.payment.value.length,
                  itemBuilder: (context, index) {
                    return PaymentItemWidget(
                      payment: _paymentController.payment.value[index],
                      removePayment: () =>
                          _paymentController.removePayment(index),
                    );
                  },
                )
              ],
            ),
            //TODO include Remeaning value
            floatingActionButton: PaymentFloatingWidget(
              billTotal: state,
            ),
          ),
        );
      },
    );
  }
}
