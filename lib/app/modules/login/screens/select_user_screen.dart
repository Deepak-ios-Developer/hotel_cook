import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_user_card.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';
import 'package:base_project/app/modules/login/controller/login_controller.dart';
import 'package:base_project/app/modules/login/screens/pass_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Select User',
        subtitle: 'Business ID : MC123',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, auth, _) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: auth.users.length,
          itemBuilder: (context, index) {
            final user = auth.users[index];
            return UserCard(
              name: user.name,
              role: user.role,
              onTap: () {
                auth.selectUser(user);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PasscodeScreen()));
              },
            );
          },
        ),
      ),
    );
  }
}
