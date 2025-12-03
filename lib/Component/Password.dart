import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Component/TextField.dart';
//import 'package:untitled1/widget/another_bloc/changepage_bloc.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final String hintText;

  const PasswordInputField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    this.hintText = "Mật khẩu",
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldCustome(
      textEditingController: widget.textEditingController,
      onChanged: widget.onChanged,
      placeHolder: widget.hintText,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );
  }
}
