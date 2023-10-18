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
  const BillTypeWidget({super.key});
  // final int? index;

  @override
  State<BillTypeWidget> createState() => _BillTypeWidgetState();
}

class _BillTypeWidgetState extends State<BillTypeWidget> {
  final billTypeStore = Modular.get<BillTypeStore>();
  // final billTypesStore = Modular.get<BillTypesStore>();
  final billTypesController = Modular.get<BillTypeController>();

  Future<void> popAndLoad() async {
    await Modular.get<BillTypesStore>()
        .getBillTypes()
        .then((value) => Navigator.of(context).pop());
  }

  // BillType? billType;

  @override
  void initState() {
    // billType = widget.index != null ? billTypesStore.state[widget.index!] : null;
    // billTypesController
    //   ..index = widget.index
    //   ..resetFields();

    billTypesController.addListener(() {
      setState(() {});
    });

    billTypeStore.observer(
      onState: (error) {
        Navigator.of(context).canPop()
            ? popAndLoad()
            : billTypesController.clearFields();
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
              key: billTypesController.formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: billTypesController.nameTextController,
                    decorationName: "Nome",
                    value: billTypesController.nameTextController.text,
                  ),
                  CustomTextFormField(
                    controller: billTypesController.valueTextController,
                    decorationName: "Valor",
                    value: billTypesController.valueTextController.text,
                    enabled:
                        billTypesController.billType != BillTypes.withoutTax,
                    keyboardType: TextInputType.number,
                    inputFormatters:
                        billTypesController.billType == BillTypes.percentageTax
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
                          value: billTypesController.defaultType,
                          onChanged: (v) {
                            billTypesController.defaultType = v;
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
                        billTypesController.billType = BillTypes.values
                            .where((element) => element.value.contains(value))
                            .first;
                      }
                    },
                    value: billTypesController.billType?.value,
                    labelText: "Tipos de Conta",
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // TODO Check here
          onPressed: () => billTypesController.saveChanges().then(
                (value) => eitherDisplayError(context, value),
              ),
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
