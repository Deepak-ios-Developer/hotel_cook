import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({Key? key, required this.text, required this.onPressed, this.isOutlined = false, this.icon, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
          foregroundColor: isOutlined ? AppColors.primary : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined ? const BorderSide(color: AppColors.primary, width: 1.5) : BorderSide.none,
          ),
        ),
        child: isLoading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
                  Text(text, style: AppTextStyles.button.copyWith(color: isOutlined ? AppColors.primary : Colors.white)),
                ],
              ),
      ),
    );
  }
}
