import 'package:flutter/material.dart';

class GlobalHelpers {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String doubleDigits(int number){
    return number.toString().padLeft(2, "0");
  }
}
