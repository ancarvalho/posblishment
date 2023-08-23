import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentTextFieldWithButtons extends StatefulWidget {
  const PaymentTextFieldWithButtons(
      {super.key,
      required this.textEditingController,
      required this.addSubtotalRemaining,
      required this.addHalfTotal,
      required this.addTotalRemaining,
      required this.addPaymentMethod});
  final TextEditingController textEditingController;
  final void Function() addSubtotalRemaining;
  final void Function() addHalfTotal;
  final void Function() addTotalRemaining;
  final void Function() addPaymentMethod;
  @override
  State<PaymentTextFieldWithButtons> createState() =>
      _PaymentTextFieldWithButtonsState();
}

class _PaymentTextFieldWithButtonsState
    extends State<PaymentTextFieldWithButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: widget.addSubtotalRemaining,
          icon: const Icon(
            Icons.percent,
            size: 32,
          ),
        ),
        TextButton(
          onPressed: widget.addHalfTotal,
          child: const Text(
            "½",
            style: TextStyle(fontSize: 32, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        SizedBox(
          width: 130,
          child: CustomTextFormField(
            controller: widget.textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decorationName: "Valor",
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        IconButton(
          onPressed: widget.addTotalRemaining,
          icon: const Icon(
            Icons.my_library_add_outlined,
            size: 32,
          ),
        ),
        IconButton(
          onPressed: widget.addPaymentMethod,
          icon: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ],
    );
  }
}
