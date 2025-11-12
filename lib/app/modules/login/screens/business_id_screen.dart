import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_custom_field.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/modules/login/controller/login_controller.dart';
import 'package:base_project/app/modules/login/screens/select_user_screen.dart';
import 'package:base_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessIdScreen extends StatelessWidget {
  const BusinessIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Consumer<AuthViewModel>(
              builder:
                  (context, auth, _) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Image(
              image: const AssetImage(AppImages.appIcon),
              width: 100,
              height: 100,
            ),
                      const SizedBox(height: 20),
                      Text(
                        'Enter Your Business ID',
                        style: AppTextStyles.heading2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CustomInputField(
                        hintText: 'Business ID',
                        prefixIcon: const Icon(
                          Icons.business,
                          color: AppColors.primary,
                        ),
                        onChanged: (value) => auth.setBusinessId(value),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: auth.rememberMe,
                              onChanged: (value) => auth.setRememberMe(value!),
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Remember me', style: AppTextStyles.body2),
                        ],
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: 'Start',
                        onPressed:
                            () => Navigator.pushNamed(context, AppRoutes.selectUser)

                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
