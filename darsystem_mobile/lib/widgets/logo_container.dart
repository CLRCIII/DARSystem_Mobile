import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final String imagePath;
  final double size;

  const LogoContainer({super.key, required this.imagePath, this.size = 84});

  @override
  Widget build(BuildContext context) {
    final bool small = size <= 36;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(small ? 4 : 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: small
            ? Colors.transparent
            : const Color.fromRGBO(255, 255, 255, 0.10),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }
}
