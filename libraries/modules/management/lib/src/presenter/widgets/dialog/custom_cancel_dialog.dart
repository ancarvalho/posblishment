import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomCancelDialog extends StatelessWidget {
  final String name, id;
  final Function delete;

  const CustomCancelDialog({Key? key, required this.name, required this.delete, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Excluir $name"),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
        ),
        SizedBox(
          height: Sizes.dp10(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: TextButton(
            onPressed: () {
              delete();
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ),
      ],
    );
  }
}
