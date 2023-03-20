import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.items,
    required this.setValue,
    this.value,
    this.isExpanded = true,
    required this.labelText,
  }) : super(key: key);
  final Map<String, String> items;
  final void Function(String? id) setValue;
  final String? value;
  final bool isExpanded;
  final String labelText;


  List<DropdownMenuItem<String>> generateDropdownMenuItems(
      Map<String, String> items) {
    return items.entries
        .map((e) => DropdownMenuItem(
              value: e.key,
              child: Text(
                e.value.toString(),
              ),
            ))
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

      style: const TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 50, 0, 58)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      value: value,
    );
  }
}