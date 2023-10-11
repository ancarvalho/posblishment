import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomDeleteDialog extends StatelessWidget {
  final String name;
  final Function delete;
  final bool isCategory;

  const CustomDeleteDialog(
      {Key? key,
      required this.name,
      required this.delete,
      this.isCategory = false,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Excluir $name"),
      children: <Widget>[
        
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
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Sair', style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),
          ),
        ),
        Text(
          "Deleting a ${isCategory ? "Category" : "Product"} can cause some issues, and you maybe won`t be able to complete this action",
        )
      ],
    );
  }
}
