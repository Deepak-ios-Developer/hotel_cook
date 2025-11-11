import 'package:base_project/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.subtitle, this.onBackPressed, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: onBackPressed != null
          ? IconButton(icon: const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textPrimary), onPressed: onBackPressed ?? () => Navigator.pop(context))
          : null,
      title: Column(
        children: [
          Text(title, style: AppTextStyles.heading3),
          if (subtitle != null) Text(subtitle!, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
        ],
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
