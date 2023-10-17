import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/utils/bill_types_formatter.dart';

import '../../widgets/bill_types/bill_types_store.dart';
import 'bill_type_store.dart';

class BillTypeWidget extends StatefulWidget {
  const BillTypeWidget({super.key, this.index});
  final int? index;

  @override
  State<BillTypeWidget> createState() => _BillTypeWidgetState();
}

class _BillTypeWidgetState extends State<BillTypeWidget> {
  final billTypeStore = Modular.get<BillTypeStore>();
  final billTypesStore = Modular.get<BillTypesStore>();

  Future<void> popAndLoad() async {
    await Modular.get<BillTypesStore>()
        .getBillTypes()
        .then((value) => Navigator.of(context).pop());
  }

  BillType? billType;

  @override
  void initState() {
    billType = widget.index != null ? billTypesStore.state[widget.index!] : null;
    billTypeStore
      ..resetFields(billType)
      ..observer(
        onState: (error) {
          Navigator.of(context).canPop()
              ? popAndLoad()
              : billTypeStore.clearFields();
        },
        onLoading: (isLoading) => setState(() {}),
        onError: (error) {
          displayMessageOnSnackbar(context, error.errorMessage);
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(billTypeStore.billType.value);
    return SafeArea(
      child: Scaffold(
        //TODO insert a Grid builder based on width minimum of 200px
        body: SingleChildScrollView(
          child: Padding(
            padding: Paddings.paddingForm(),
            child: Form(
              key: billTypeStore.formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: billTypeStore.nameTextController,
                    decorationName: "Nome",
                    value: billTypeStore.nameTextController.text,
                  ),
                  CustomTextFormField(
                    controller: billTypeStore.valueTextController,
                    decorationName: "Valor",
                    value: billTypeStore.valueTextController.text,
                    enabled:
                        billTypeStore.billType.value != BillTypes.withoutTax,
                    keyboardType: TextInputType.number,
                    inputFormatters:
                        billTypeStore.billType.value == BillTypes.percentageTax
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
                          value: billTypeStore.defaultType.value,
                          onChanged: (v) {
                            billTypeStore.defaultType.value = v;
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
                        billTypeStore.billType.value = BillTypes.values
                            .where((element) => element.value.contains(value))
                            .first;
                      }
                    },
                    value: billTypeStore.billType.value.value,
                    labelText: "Tipos de Conta",
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () {
            billTypeStore.saveChanges(billType?.id);
            // .then(
            //       (value) => eitherDisplayError(context, value),
            //     );
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
