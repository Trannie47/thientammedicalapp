import 'package:flutter/material.dart';
import 'package:thientammedicalapp/control/ControlSharePreference.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';
import 'package:thientammedicalapp/models/userLogin.dart';
import 'package:thientammedicalapp/pages/main/about/changepassword/page.dart';
import 'package:thientammedicalapp/responsity/LoginReponsity.dart';
import 'package:thientammedicalapp/responsity/NhanVienReponsity.dart';
import 'package:thientammedicalapp/services/api_service.dart';
import '../../Component/Logo.dart';
import '../../Value/app_assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userIDController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isRemeberme = false;
  late bool _accesskey ;

  @override
  void dispose() {
    _userIDController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String manv = _userIDController.text;
      String matkhau = _passwordController.text;
      late NhanVien nhanVien;
      //NV891
      //matkhauMoiCuaToi123
      _accesskey = await accessToken(manv, matkhau);
      if (_accesskey) {
        await ApiService.init();
        //Lưu nhân viên khi lấy ra
        nhanVien = await getNhanVienByID(manv);
        nhanVien.copyWith(matKhau: matkhau);
        await saveNhanVienSharedPreferences(nhanVien);

        await deleteUserLogin();
        if (_isRemeberme) { //Nếu lưu thông tin sẽ Save tài khoản lại cho lần đăng nhập kế tiếp
          UserLogin userLogin = new UserLogin(taiKhoan: manv, matKhau: matkhau,rememberMe: true);
          saveUserLogin(userLogin);
        }
      }


      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(_accesskey ?'Đăng nhập thành công!' : 'ĐĂNG NHẬP THẤT BẠI'),
            backgroundColor: Color(0xFF1B4D4A),
          ),
        );
      });
      if (_accesskey) {
        if (nhanVien.mustChangePassword) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(isFirstPass: true),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/main');
        }
      }

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userIDController.text ='NV891';
    _passwordController.text='matkhauMoiCuaToi123';


  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logoSize = screenSize.width * 0.4; // Responsive logo size
    
    return Scaffold(
      body: Container(
        height: screenSize.height,
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage( AppAssets.bgLogin),
            fit: BoxFit.cover,
            opacity: 0.8,             // tuỳ chọn: làm mờ nền một chút cho chữ dễ đọc
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenSize.height * 0.04),
                  // Logo THIÊN TÂM
                  Center(
                    child: ThienTamLogo(
                       size: logoSize.clamp(120.0, 120.0),
                      height: 100,
                      width: 165,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.35),

                  // Email field
                  Container(
                    height: screenSize.height,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.7),       // màu xám nhẹ
                      borderRadius: BorderRadius.circular(20), // bo góc 20px
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã Nhân Nhân Viên',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        TextFormField(
                          controller: _userIDController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04 > 16 ? 16 : screenSize.width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Nhập mã nhân viên của bạn',
                            prefixIcon: const Icon(Icons.email_outlined, size: 22),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFF1B4D4A),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.red, width: 1.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        // Password field
                        Text('Mật khẩu',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleLogin(),
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04 > 16 ? 16 : screenSize.width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu của bạn',
                            prefixIcon: const Icon(Icons.lock_outlined, size: 22),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFF1B4D4A),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.red, width: 1.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (value.length < 6) {
                              return 'Mật khẩu phải có ít nhất 6 ký tự';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.015),
                        // Quên mật khẩu
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035 > 13 ? 13 : screenSize.width * 0.035,
                                color: const Color(0xFF1B4D4A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _isRemeberme,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isRemeberme = value ?? false;
                                });
                              },
                              activeColor: Color(0xFF1B4D4A), // màu khi checked
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Ghi nhớ thông tin',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.025),

                        // Login button
                        Center(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B4D4A),
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shadowColor: Colors.black26,
                                disabledBackgroundColor: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                textStyle: TextStyle(
                                  fontSize: screenSize.width * 0.045 > 17 ? 17 : screenSize.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                                  : const Text('Đăng Nhập'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

