import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomBillTypeDialog extends StatelessWidget {
  // TODO change for suit better another models
  final String type;
  final Function setDefault;
  final Function delete;


  const CustomBillTypeDialog({
    Key? key,
    required this.type,
    required this.setDefault,
    required this.delete,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Acoes $type"),
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: Paddings.paddingLTRB4(),
          child: Column(
            children: [
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  delete();
                  Navigator.pop(context);
                },
                child:  Text('Deletar $type'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  setDefault();
                  Navigator.pop(context);
                },
                child: const Text('Tornar Padrão'),
              ),
              SizedBox(
                height: Sizes.dp10(context),
              ),
          
              SizedBox(
                height: Sizes.dp10(context),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Sair'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
