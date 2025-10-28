import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Component/TextField.dart';
//import 'package:untitled1/widget/another_bloc/changepage_bloc.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;

  const PasswordInputField(
      {super.key,
        required this.textEditingController,
        required this.onChanged});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  late final TextEditingController _textEditingController;
  late final Function(String) _onChanged;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = widget.textEditingController;
    _onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldCustome(onChanged: _onChanged, textEditingController: _textEditingController);
  }
}