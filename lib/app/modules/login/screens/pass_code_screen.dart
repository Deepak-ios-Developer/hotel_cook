import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/modules/menu/views/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/login_controller.dart';

class PasscodeScreen extends StatelessWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<AuthViewModel>(
          builder: (context, auth, _) => Column(
            children: [
              const SizedBox(height: 60),
              Text('Pass Code', style: AppTextStyles.heading2),
              const SizedBox(height: 8),
              if (auth.passcode.length == 6 && !auth.isLoading)
                Text('Password is incorrect', style: AppTextStyles.caption.copyWith(color: AppColors.error)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: index < auth.passcode.length ? AppColors.textPrimary : AppColors.border,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              _buildNumPad(context, auth),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryButton(
                  text: 'Log In',
                  onPressed: () async {
                    final success = await auth.verifyPasscode();
                    if (success) {
                      auth.clearPasscode();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MenuScreen()));
                    }
                  },
                  isLoading: auth.isLoading,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumPad(BuildContext context, AuthViewModel auth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildNumRow(['1', '2', '3'], auth),
          const SizedBox(height: 20),
          _buildNumRow(['4', '5', '6'], auth),
          const SizedBox(height: 20),
          _buildNumRow(['7', '8', '9'], auth),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 80, height: 80),
              _buildNumButton('0', auth),
              InkWell(
                onTap: () => auth.removePasscodeDigit(),
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Icon(Icons.backspace_outlined, size: 28, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumRow(List<String> numbers, AuthViewModel auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((num) => _buildNumButton(num, auth)).toList(),
    );
  }

  Widget _buildNumButton(String number, AuthViewModel auth) {
    return InkWell(
      onTap: () => auth.addPasscodeDigit(number),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Text(number, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
      ),
    );
  }
}
