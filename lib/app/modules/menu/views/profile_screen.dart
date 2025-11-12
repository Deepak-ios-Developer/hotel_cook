import 'package:flutter/material.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/app_custom_field.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      appBar: CustomAppBar(
        title: 'Profile',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            const SizedBox(height: 30),

            // Mobile Number
            Text('Mobile Number', style: AppTextStyles.body1),
            const SizedBox(height: 8),
            CustomInputField(
              hintText: '+918375248552',
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: AppColors.iconColor,
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),

            // Outlet ID
            Text('Outlet ID', style: AppTextStyles.body1),
            const SizedBox(height: 8),
            CustomInputField(
              hintText: 'MC123',
              prefixIcon: const Icon(
                Icons.store_outlined,
                color: AppColors.iconColor,
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),

            // Password
            Text('Password', style: AppTextStyles.body1),
            const SizedBox(height: 8),
            CustomInputField(
              hintText: '********',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.iconColor,
              ),
              suffixIcon: const Icon(
                Icons.visibility_outlined,
                color: AppColors.iconColor,
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),

            // Outlet Details
            Text('Outlet Details', style: AppTextStyles.body1),
            const SizedBox(height: 8),
            CustomInputField(
              hintText: 'Roasta & More, London',
              prefixIcon: const Icon(
                Icons.location_on_outlined,
                color: AppColors.iconColor,
              ),
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
