import 'package:base_project/app/modules/menu/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.grey.shade100,

        width: screenWidth * 0.8,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFFFA726),
                      child: Icon(Icons.person, size: 35, color: Colors.white),
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
              _buildMenuItem(
                icon: Icons.person_outline,
                label: "Profile",
                hasTrailing: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
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
              _buildMenuItem(
                icon: Icons.logout,
                label: "Log Out",
                onTap: () {},
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? AppColors.textPrimary,
          size: 22,
        ),
        title: Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing:
            hasTrailing
                ? Icon(
                  Icons.chevron_right,
                  color: color ?? AppColors.textPrimary,
                )
                : null,
        onTap: onTap,
      ),
    );
  }
}
