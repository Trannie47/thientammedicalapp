import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Component/Password.dart';
import 'package:thientammedicalapp/pages/main/page.dart';
import 'package:thientammedicalapp/responsity/NhanVienReponsity.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool? isFirstPass;
  const ChangePasswordScreen({super.key, this.isFirstPass});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldController = TextEditingController();
  final newController = TextEditingController();
  final reNewController = TextEditingController();
  bool _isFirstPass = false;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isFirstPass = widget.isFirstPass ?? false;
      _isLoading = false;
    });
  }

  void _handleSavePassword() async {
    // setState(() {
    //   _isLoading = true;
    // });
    String mMessage = "";
    String OldPass = oldController.text;
    String newPass = newController.text;
    String rePass = reNewController.text;
    if (newPass != rePass) {
      mMessage = 'Mật khẩu xác nhân không giống nhau';
    } else if (OldPass == newPass) {
      mMessage = 'Mật khẩu mới và cũ trùng nhau ';
    }
    if (mMessage == "" && _isFirstPass == true) {
      await changeNewPassword(newPass);
    } else if (mMessage == "") {
      await changePassword(newPass: newPass,oldPass:OldPass );
    }


    if (mMessage == "") {
      if (_isFirstPass == false) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isFirstPass == false
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text("Đổi mật khẩu"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _handleSavePassword,
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  _isFirstPass == false
                      ? PasswordInputField(
                          textEditingController: oldController,
                          hintText: 'Mật khẩu cũ',
                          onChanged: (value) {
                            // validate nếu cần
                          },
                        )
                      : const SizedBox.shrink(),

                  PasswordInputField(
                    hintText: 'Mật khẩu mới',
                    textEditingController: newController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  PasswordInputField(
                    hintText: 'Mật khẩu xác nhận',
                    textEditingController: reNewController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
