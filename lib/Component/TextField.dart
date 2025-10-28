import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget TextFieldCustome(
    {String? title,
      TextStyle? titleStyle,
      String? placeHolder,
      TextStyle? placeHolderStyle,
      int? maxLength,
      bool multiLine = false,
      IconData? prefixIcon,
      Color prefixIconColor = Colors.black,
      Widget? suffixIcon,
      bool countNumberInput = false,
      required Function(String) onChanged,
      required TextEditingController textEditingController}) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
          title != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(title,
                  style: (titleStyle != null)
                      ? titleStyle.copyWith(
                    fontWeight: titleStyle.fontWeight ?? FontWeight.w500,
                    fontSize: titleStyle.fontSize ?? 32,
                  )
                      : const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
            if (countNumberInput)
              Container(
                child: Text(
                  "${textEditingController.value.text.length.toString()}${maxLength != null ? "/$maxLength" : ""}",
                  style: titleStyle != null
                      ? titleStyle.copyWith(
                    fontWeight: titleStyle.fontWeight ?? FontWeight.w500,
                    fontSize: titleStyle.fontSize ?? 32,
                  )
                      : const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
          ],
        ),
        TextField(
          maxLines: (multiLine == false) ? 1 : null,
          onChanged: onChanged,
          minLines: (multiLine == false) ? 1 : 3,
          controller: textEditingController,
          maxLength: maxLength,
          decoration: InputDecoration(
              labelText: placeHolder,
              labelStyle: placeHolderStyle,
              prefixIcon: (prefixIcon != null ? Icon(prefixIcon) : null),
              suffixIcon: suffixIcon,
              border: const OutlineInputBorder(),
              counterText: ""),
        )
      ],
    ),
  );
}