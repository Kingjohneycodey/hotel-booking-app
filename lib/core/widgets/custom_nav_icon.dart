import 'package:flutter/material.dart';

class CustomNavIcon extends StatelessWidget {
  final String activeIconPath;
  final String inactiveIconPath;
  final bool isActive;
  final double size;

  const CustomNavIcon({
    super.key,
    required this.activeIconPath,
    required this.inactiveIconPath,
    required this.isActive,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isActive ? activeIconPath : inactiveIconPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
