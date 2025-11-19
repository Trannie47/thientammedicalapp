import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_assets.dart';

class ThienTamLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final double? width;
  final double? height;

  const ThienTamLogo({
    super.key,
    this.size = 200,
    this.showText = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textSize = size * 0.24;
    var lazysize = MediaQuery
        .of(context)
        .size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo trái tim
        Image.asset(AppAssets.logo,
          fit: BoxFit.fill,
          width: (width == null) ? lazysize.width * 0.75 : width,
          height: (height == null) ? lazysize.width * 0.75 : height,
        ),

      ],
    );
  }
}



