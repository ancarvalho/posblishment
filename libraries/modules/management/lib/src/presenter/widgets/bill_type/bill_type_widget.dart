import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/utils/bill_types_formatter.dart';

import '../../widgets/bill_types/bill_types_store.dart';
import 'bill_type_controller.dart';
import 'bill_type_store.dart';

class BillTypeWidget extends StatefulWidget {
  const BillTypeWidget({super.key, this.index});
  final int? index;

  @override
  State<BillTypeWidget> createState() => _BillTypeWidgetState();
}

class _BillTypeWidgetState extends State<BillTypeWidget> {
  final billTypeStore = Modular.get<BillTypeStore>();
  final billTypeController = BillTypeController();
  final billTypesStore = Modular.get<BillTypesStore>();

  Future<void> popAndLoad() async {
    await Modular.get<BillTypesStore>()
        .getBillTypes()
        .then((value) => Navigator.of(context).pop());
  }

  @override
  void initState() {
    billTypeController.addListener(() {
      setState(() {});
    });

    billTypeStore.observer(
      onState: (error) {
        Navigator.of(context).canPop()
            ? popAndLoad()
            : billTypeController.clearFields();
      },
      onError: (error) {
        displayMessageOnSnackbar(context, error.errorMessage);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final billType =
        widget.index != null ? billTypesStore.state[widget.index!] : null;
    billTypeController.resetFields(billType);
    debugPrint(billTypeController.billType.value);
    return SafeArea(
      child: Scaffold(
        //TODO insert a Grid builder based on width minimum of 200px
        body: SingleChildScrollView(
          child: Padding(
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
                        billTypeController.billType != BillTypes.withoutTax,
                    keyboardType: TextInputType.number,
                    inputFormatters:
                        billTypeController.billType == BillTypes.percentageTax
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
                          value: billTypeController.defaultType,
                          onChanged: (v) {
                            billTypeController.defaultType = v;
                          },
                        ),
                      ],
                    ),
                  ),
                  // CustomDropDown(
                  //   // key: UniqueKey(),
                  //   items: <String, String>{
                  //     for (var billType in BillTypes.values)
                  //       billType.value: billType.name
                  //   },
                  //   setValue: (value) {
                  //     if (value != null) {
                  //       billTypeController.billType = BillTypes.values
                  //           .where((element) => element.value.contains(value))
                  //           .first;
                  //     }
                  //   },
                  //   value: billTypeController.billType.value,
                  //   labelText: "Tipos de Conta",
                  // ),
                  DropdownButtonFormField(
                    // key: UniqueKey(),
                    
                    items: BillTypes.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        billTypeController.billType = BillTypes.values
                            .where((element) => element.value.contains(value))
                            .first;
                      }
                    },
                    value: billTypeController.billType.value,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () {
            billTypeController.saveChanges(billType?.id).then(
                  (value) => eitherDisplayError(context, value),
                );
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
