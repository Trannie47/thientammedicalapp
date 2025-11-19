import 'package:flutter/material.dart';
import '../../widgets/thien_tam_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập thành công!'),
            backgroundColor: Color(0xFF1B4D4A),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logoSize = screenSize.width * 0.4; // Responsive logo size
    
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenSize.height * 0.04),
                // Logo THIÊN TÂM
                Center(
                  child: ThienTamLogo(
                    size: logoSize.clamp(140.0, 160.0),
                    showText: true,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                // Tiêu đề
                Text(
                  'Đăng Nhập',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.08 > 28 ? 28 : screenSize.width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B4D4A),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  'Vui lòng đăng nhập để tiếp tục',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.038 > 14 ? 14 : screenSize.width * 0.038,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04 > 16 ? 16 : screenSize.width * 0.04,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập email của bạn',
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
                    if (!value.contains('@')) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.02),
                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04 > 16 ? 16 : screenSize.width * 0.04,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                SizedBox(height: screenSize.height * 0.025),
                // Login button
                SizedBox(
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
                SizedBox(height: screenSize.height * 0.03),
                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'HOẶC',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.032 > 12 ? 12 : screenSize.width * 0.032,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.025),
                // Đăng ký text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chưa có tài khoản? ',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035 > 14 ? 14 : screenSize.width * 0.035,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle register
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Đăng Ký',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.038 > 15 ? 15 : screenSize.width * 0.038,
                          color: const Color(0xFF1B4D4A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

