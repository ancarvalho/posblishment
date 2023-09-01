import 'package:administration/src/presenter/pages/bill_type/bill_type_controller.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/utils/bill_types_formatter.dart';
import 'bill_type_store.dart';

class BillTypePage extends StatefulWidget {
  const BillTypePage({super.key, this.billType});
  final BillType? billType;

  @override
  State<BillTypePage> createState() => _BillTypePageState();
}

class _BillTypePageState extends State<BillTypePage> {
  final billTypeStore = Modular.get<BillTypeStore>();
  final billTypeController = BillTypeController();

  @override
  void initState() {
    billTypeController.resetFields(widget.billType);
    billTypeController.billType.addListener(() {
      setState(() {
        billTypeController.valueTextController.text = "";
      });
    });
    billTypeController.defaultType.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Tipo de Conta"),
          centerTitle: true,
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body: Padding(
          padding: Paddings.paddingForm(),
          child: Form(
            key: billTypeController.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: billTypeController.nameTextController,
                  decorationName: "Nome",
                  value: billTypeController.nameTextController.text,
                ),
                CustomTextFormField(
                  controller: billTypeController.valueTextController,
                  decorationName: "Valor",
                  value: billTypeController.valueTextController.text,
                  enabled:
                      billTypeController.billType.value != BillTypes.withoutTax,
                  keyboardType: TextInputType.number,
                  inputFormatters: billTypeController.billType.value ==
                          BillTypes.percentageTax
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                          PercentageBillTypeValue()
                        ]
                      : [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                ),
                Padding(
                  padding: Paddings.paddingVertical8(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tipo Padrão",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Switch(
                        value: billTypeController.defaultType.value,
                        onChanged: (_) {
                          billTypeController.defaultType.value =
                              !billTypeController.defaultType.value;
                        },
                      ),
                    ],
                  ),
                ),
                
                CustomDropDown(
                  items: <String, String>{
                    for (var billType in BillTypes.values)
                      billType.value: billType.name
                  },
                  setValue: (value) {
                    if (value != null) {
                      billTypeController.billType.value = BillTypes.values
                          .where((element) => element.value.contains(value))
                          .first;
                    }
                  },
                  value: billTypeController.billType.value.value,
                  labelText: "Tipos de Conta",
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () {
            billTypeController.saveChanges(widget.billType?.id).then(
                  (value) => value.fold(
                    (l) => displayMessageOnSnackbar(context, l.errorMessage),
                    (r) => null,
                  ),
                );
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
