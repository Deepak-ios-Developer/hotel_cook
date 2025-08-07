import 'package:flutter/material.dart';

void showCommonSnackbar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.black,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
