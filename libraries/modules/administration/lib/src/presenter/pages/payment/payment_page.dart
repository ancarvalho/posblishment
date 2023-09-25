import 'package:administration/src/presenter/pages/payment/payment_controller.dart';
import 'package:administration/src/presenter/pages/payment/payment_store.dart';
import 'package:administration/src/presenter/stores/bill/bill_total_store.dart';
import 'package:administration/src/presenter/widgets/payment/payment_item_widget.dart';
import 'package:administration/src/presenter/widgets/payment/payment_text_field_with_buttons_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/payment/payment_floating_widget.dart';
import '../../widgets/payment/payment_methods_widget.dart';
import '../bills/bills_store.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.billID});
  final String billID;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _billTotalStore = Modular.get<BillTotalStore>();
  final _paymentStore = Modular.get<PaymentStore>();
  final PaymentController _paymentController = PaymentController();

  late Disposer _paymentStoreObserverDisposer;

  @override
  void initState() {
    _paymentStoreObserverDisposer = _paymentStore.observer(
      onState: (_) {
        Modular.get<NotPaidBillsStore>().getNotPaidBills();
        Navigator.pop(context);
      },
      onError: (error) => displayMessageOnSnackbar(context, error.errorMessage),
    );

    _paymentController.addListener(() {
      setState(() {});
    });

    _billTotalStore.getBillTotal(widget.billID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BillTotalStore, Failure, BillTotal>(
      store: _billTotalStore,
      onState: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Pagamento",
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(_paymentController.currentPaymentType.name),
                  PaymentMethodsWidget(
                    paymentType: _paymentController.currentPaymentType,
                    selectPaymentType: _paymentController.setCurrentPaymentType,
                  ),
                  const SizedBox(
                    height: 8,
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
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _paymentController.payments.value.length,
                      itemBuilder: (context, index) {
                        return PaymentItemWidget(
                          payment: _paymentController.payments.value[index],
                          removePayment: () =>
                              _paymentController.removePayment(index),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            //TODO include Remeaning value
            floatingActionButton: PaymentFloatingWidget(
              billTotal: state,
              finalizeBill: () =>
                  _paymentController.finalizeBill(widget.billID),
              calculateRemaining: _paymentController.calculateTotalRemaining,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _paymentStoreObserverDisposer();
    _paymentController.dispose();
    super.dispose();
  }
}
