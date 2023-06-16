import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.items,
    required this.setValue,
    this.value,
    this.isExpanded = true,
    required this.labelText,
    this.validator,
  }) : super(key: key);
  final Map<String, String> items;
  final void Function(String? value) setValue;
  final String? value;
  final bool isExpanded;
  final String labelText;
  final String? Function(String?)? validator;

  List<DropdownMenuItem<String>> generateDropdownMenuItems(
    Map<String, String> items,
  ) {
    return items.entries
        .map(
          (e) => DropdownMenuItem(
            value: e.key,
            child: Text(
              e.value,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: generateDropdownMenuItems(items),
      isExpanded: true,
      onChanged: setValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      validator: validator,
      // TODO check this color
      style:  TextStyle(color: Theme.of(context).colorScheme.primary),
      
      decoration: InputDecoration(

        labelText: labelText,
        
        // labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      value: value,
    );
  }
}
