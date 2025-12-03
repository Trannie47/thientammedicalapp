import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget TextFieldCustome({
  String? title,
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
  required TextEditingController textEditingController,
  bool obscureText = false, // thêm tham số này
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle ??
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              if (countNumberInput)
                Text(
                  "${textEditingController.text.length}${maxLength != null ? "/$maxLength" : ""}",
                  style: titleStyle ??
                      const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
            ],
          ),
        const SizedBox(height: 8),
        TextField(
          controller: textEditingController,
          onChanged: onChanged,
          maxLines: multiLine ? null : 1,
          minLines: multiLine ? 3 : 1,
          maxLength: maxLength,
          obscureText: obscureText, // dùng đây
          decoration: InputDecoration(
            labelText: placeHolder,
            labelStyle: placeHolderStyle,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: prefixIconColor) : null,
            suffixIcon: suffixIcon, // override từ bên ngoài nếu cần toggle
            border: const OutlineInputBorder(),
            counterText: "",
          ),
        ),
      ],
    ),
  );
}
