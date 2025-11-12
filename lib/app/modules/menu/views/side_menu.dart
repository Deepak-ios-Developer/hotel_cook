import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/app/modules/menu/views/profile_screen.dart';
import 'package:base_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight*5, // ✅ fills full screen height
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                     Image(
              image: const AssetImage(AppImages.profile),
              width: 80,
              height: 80,
            ),
                    const SizedBox(width: 12),
                    Text(
                      "Jimmy Bob",
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 25),
              // Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                label: "Profile",
                hasTrailing: true,
                onTap: () {
                  Navigator.pop(context);
                 Navigator.pushNamed(context, AppRoutes.profile);

                },
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.headset_mic_outlined,
                label: "Support",
                color: Colors.white,
                bgColor: AppColors.primary,
                iconColor: Colors.white,
                hasTrailing: true,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _buildMenuItem(
                icon: Icons.dark_mode_outlined,
                label: "Dark Mode",
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.logout,
                label: "Log Out",
                onTap: () {},
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    Color? color,
    Color? iconColor,
    Color? bgColor,
    bool hasTrailing = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: iconColor ?? AppColors.textPrimary, size: 22),
        title: Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: hasTrailing
            ? Icon(Icons.chevron_right, color: color ?? AppColors.textPrimary)
            : null,
        onTap: onTap,
      ),
    );
  }
}
