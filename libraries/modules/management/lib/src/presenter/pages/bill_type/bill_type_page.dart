import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import '../../widgets/bill_type/bill_type_widget.dart';


class BillTypePage extends StatefulWidget {
  const BillTypePage({super.key, this.index});
  final int? index;

  @override
  State<BillTypePage> createState() => _BillTypePageState();
}

class _BillTypePageState extends State<BillTypePage> {
 



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Navigator.of(context).canPop() ? null : const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Tipo de Conta"),
          centerTitle: true,
        ),
        //TODO insert a Grid builder based on width minimum of 200px
        body:  BillTypeWidget(index: widget.index,)
       
      ),
    );
  }
}
