import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/use_cases/usecases.dart';
import 'package:management/src/presenter/widgets/dialog/bill_type_dialog.dart';

import '../../../domain/utils/format_bill_type_value.dart';

class BillTypeCardWidget extends StatelessWidget {
  BillTypeCardWidget({super.key, required this.billType, this.setIndex, required this.index});
  final Function(int index)? setIndex;
  final int index;
  final BillType billType;

  final setBillTypeDefault = Modular.get<ISetBillTypeDefault>();
  final deleteBillType = Modular.get<IDeleteBillType>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Sizes.isMobile(context)
          ? () => Modular.to.pushNamed(
                "${PagesRoutes.billType.dependsOnModule.route}${PagesRoutes.billType.route}",
                arguments: index,
              )
          : () => setIndex!(index),
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => CustomBillTypeDialog(
          delete: () => deleteBillType.call(billType.id),
          setDefault: () => setBillTypeDefault.call(billType.id),
          type: billType.name,
        ),
      ),
      child: Card(
        child: ConstrainedBox(
          // height: 180,
          constraints: const BoxConstraints(
            maxHeight: 100,
            minWidth: 150,
            // maxWidth: 180,
            minHeight: 60,
          ),
          child: Padding(
            padding: Paddings.paddingLTRB8(),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          billType.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    if (billType.value != null)
                      Text(
                        formatBillTypeValue(
                          billType.type,
                          billType.value!,
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
