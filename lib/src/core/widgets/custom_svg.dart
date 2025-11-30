import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
    this.fit,
  });
  final String path;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter:
      color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      fit: fit ?? BoxFit.contain,
    );
  }
}