import 'package:flutter/material.dart';

import '../../design_system.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final bool isSelected;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isSelected = false,})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.width(context)*.001),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: widget.isSelected
              ? Theme.of(context).colorScheme.secondary
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .titleLarge?.copyWith(fontSize: Sizes.isMobile(context) ? Sizes.dp14(context) : Sizes.dp7(context))
              ,
        ),
      ),
    );
  }
}
