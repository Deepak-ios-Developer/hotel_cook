import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Color color;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.color = Colors.white,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}
