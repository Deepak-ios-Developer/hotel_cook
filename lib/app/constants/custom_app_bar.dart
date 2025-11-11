import 'package:base_project/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 70,
      // ✅ Circular Back Button
      leading: onBackPressed != null
          ? Container(
              margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    size: 18, color: AppColors.textPrimary),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              ),
            )
          : null,

      // ✅ Title & Subtitle
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3
                .copyWith(fontWeight: FontWeight.w600),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: AppTextStyles.caption
                  .copyWith(color: AppColors.primary),
            ),
          ],
        ],
      ),

      // ✅ Circular Action Buttons
      actions: actions != null
          ? actions!
              .map(
                (widget) => Container(
                  margin:
                      const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: widget,
                ),
              )
              .toList()
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
