import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value; // từ 0.0 đến 1.0
  final double height;
  final Color fillColorStart;
  final Color fillColorEnd;
  final Duration duration;

  const ProgressBar({
    Key? key,
    required this.value,
    this.height = 12.0,
    this.fillColorStart = const Color(0xFF00C6FF),
    this.fillColorEnd = const Color(0xFF0072FF),
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: const Color(0xFFE8E8E8), // viền nhạt
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedFractionallySizedBox(
              duration: duration,
              curve: Curves.easeInOut,
              widthFactor: clampedValue,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  gradient: LinearGradient(
                    colors: [fillColorStart, fillColorEnd],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
