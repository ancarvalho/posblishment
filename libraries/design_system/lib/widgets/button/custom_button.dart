import 'package:flutter/material.dart';

import '../../design_system.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.width(context) * .14,
      height: Sizes.width(context) / 12,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: ColorPalettes.darkAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Sizes.dp10(context),
            ),
            side: BorderSide(
              color: ColorPalettes.darkAccent,
            ),
          ),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
      ),
    );
  }
}
