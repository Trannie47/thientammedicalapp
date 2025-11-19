import 'package:flutter/material.dart';
import '../../widgets/thien_tam_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logoSize = screenSize.width * 0.5; // Responsive logo size
    
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.08,
              ),
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo THIÊN TÂM
                            ThienTamLogo(
                              size: logoSize.clamp(180.0, 220.0),
                              showText: true,
                            ),
                            SizedBox(height: constraints.maxHeight * 0.06),
                            // Nút chuyển đến màn hình login
                            SizedBox(
                              width: constraints.maxWidth * 0.84,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _navigateToLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B4D4A),
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shadowColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: screenSize.width * 0.045 > 18 ? 18 : screenSize.width * 0.045,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                child: const Text('Bắt Đầu'),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.025),
                            // Text mô tả
                            Text(
                              'Chào mừng đến với THIÊN TÂM',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.038 > 15 ? 15 : screenSize.width * 0.038,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

