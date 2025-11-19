import 'package:flutter/material.dart';

class ThienTamLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const ThienTamLogo({
    super.key,
    this.size = 200,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final textSize = size * 0.24;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo trái tim
        CustomPaint(
          size: Size(size, size * 0.9),
          painter: HeartLogoPainter(),
        ),
        if (showText) ...[
          SizedBox(height: size * 0.08),
          // Text "THIÊN TÂM"
          Text(
            'THIÊN TÂM',
            style: TextStyle(
              fontSize: textSize > 20 ? 20 : textSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B4D4A),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

class HeartLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = size.width * 0.35;

    // Vẽ nửa trái tim bên trái (cam-đỏ sáng)
    paint.shader = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFFF8C69), // Cam-đỏ sáng hơn
        Color(0xFFFF6B6B), // Cam-đỏ
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width / 2, size.height));

    final leftPath = Path();
    // Vẽ nửa trái của trái tim
    leftPath.moveTo(centerX, centerY + scale * 0.8);
    
    // Đường cong dưới bên trái
    leftPath.cubicTo(
      centerX - scale * 0.5,
      centerY + scale * 0.4,
      centerX - scale * 1.2,
      centerY - scale * 0.2,
      centerX - scale * 0.8,
      centerY - scale * 0.6,
    );
    
    // Đường cong trên bên trái (vòng tròn trên)
    leftPath.cubicTo(
      centerX - scale * 0.9,
      centerY - scale * 1.0,
      centerX - scale * 0.4,
      centerY - scale * 1.1,
      centerX,
      centerY - scale * 0.8,
    );
    
    // Đường xuống điểm giữa
    leftPath.lineTo(centerX, centerY + scale * 0.8);
    leftPath.close();

    canvas.drawPath(leftPath, paint);

    // Vẽ nửa trái tim bên phải (đỏ đậm)
    paint.shader = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFD73027), // Đỏ đậm
        Color(0xFFA11D1D), // Đỏ rất đậm
      ],
    ).createShader(Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height));

    final rightPath = Path();
    // Vẽ nửa phải của trái tim
    rightPath.moveTo(centerX, centerY + scale * 0.8);
    
    // Đường cong dưới bên phải
    rightPath.cubicTo(
      centerX + scale * 0.5,
      centerY + scale * 0.4,
      centerX + scale * 1.2,
      centerY - scale * 0.2,
      centerX + scale * 0.8,
      centerY - scale * 0.6,
    );
    
    // Đường cong trên bên phải (vòng tròn trên)
    rightPath.cubicTo(
      centerX + scale * 0.9,
      centerY - scale * 1.0,
      centerX + scale * 0.4,
      centerY - scale * 1.1,
      centerX,
      centerY - scale * 0.8,
    );
    
    // Đường xuống điểm giữa
    rightPath.lineTo(centerX, centerY + scale * 0.8);
    rightPath.close();

    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

