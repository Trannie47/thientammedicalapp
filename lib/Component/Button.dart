import 'package:flutter/material.dart';

enum TypeButton {
  ERROR,
  INFO,
  SUCCESS,
}

Widget Button(Function() onPressed, String text,
    {TypeButton typeButton = TypeButton.INFO}) {
  Color buttonColor = Colors.white;

  switch (typeButton) {
    case TypeButton.ERROR:
      buttonColor = Colors.red;
      break;
    case TypeButton.INFO:
      buttonColor = Colors.blue;
      break;
    default:
      buttonColor = Colors.green;
      break;
  }

  return ElevatedButton(
    onPressed: onPressed,
    child: Text("$text"),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(buttonColor)),
  );
}