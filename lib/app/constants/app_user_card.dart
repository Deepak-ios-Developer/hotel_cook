import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback onTap;

  const UserCard({Key? key, required this.name, required this.role, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.lightPurple,
              child: Text(name[0].toUpperCase(), style: AppTextStyles.body1.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(role, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
