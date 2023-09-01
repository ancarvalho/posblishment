import 'package:flutter/material.dart';

class Paddings {
  static EdgeInsets paddingLTRB4() {
    return const EdgeInsets.all(4);
  }

  static EdgeInsets paddingLTRB20() {
    return const EdgeInsets.all(20);
  }

  static EdgeInsets paddingLTRB8() {
    return const EdgeInsets.all(8);
  }

  static EdgeInsets paddingHorizontal4() {
    return const EdgeInsets.symmetric(horizontal: 4);
  }

  static EdgeInsets paddingHorizontal8() {
    return const EdgeInsets.symmetric(horizontal: 8);
  }

  static EdgeInsets paddingVertical4() {
    return const EdgeInsets.symmetric(vertical: 4);
  }

  static EdgeInsets paddingVertical8() {
    return const EdgeInsets.symmetric(vertical: 8);
  }

  static EdgeInsets paddingVertical8Horizontal4() {
    return const EdgeInsets.symmetric(vertical: 8, horizontal: 4);
  }

  static EdgeInsets paddingForm() {
    return const EdgeInsets.symmetric(horizontal: 12, vertical: 20);
  }
}
