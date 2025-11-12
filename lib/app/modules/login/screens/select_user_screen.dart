import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_user_card.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';
import 'package:base_project/app/modules/login/controller/login_controller.dart';
import 'package:base_project/app/modules/login/screens/pass_code_screen.dart';
import 'package:base_project/app/routes/app_routes.dart';
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
        builder: (context, auth, _) {
          final users = auth.users;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GridView.builder(
              itemCount: users.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 12, // horizontal space
                mainAxisSpacing: 12, // vertical space
                childAspectRatio: 1.3, // aspect ratio for card shape
              ),
              itemBuilder: (context, index) {
                final user = users[index];
                final isSelected = auth.selectedUser == user;

                return GestureDetector(
                  onTap: () {
                    auth.selectUser(user);
                  Navigator.pushNamed(context, AppRoutes.passcode);

                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: 
                            Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.role,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
