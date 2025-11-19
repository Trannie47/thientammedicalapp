import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Component/ProgressBar.dart';
import 'package:thientammedicalapp/Value/app_color.dart';
import '../../Component/Logo.dart';

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
  late double _indexProcessBar = 0;

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

    Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        _indexProcessBar += 0.18;

        if (_indexProcessBar >= 1) {
          _indexProcessBar = 1;
          timer.cancel();                 // dừng lại -> hoàn tất
          Future.delayed(Duration(milliseconds: 400), _navigateToLogin);
        }
      });
    });
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
                            // Text mô tả
                            Text(
                              'Quản lý kho dễ dàng – Hiệu quả mỗi ngày',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColor.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Row(
                              children: [
                                const SizedBox(width: 10), // khoảng cách
                                Expanded(
                                  child: ProgressBar(
                                    value: _indexProcessBar,
                                    duration: Duration(seconds: 1),
                                  ),
                                ),
                              ],
                            )


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

