import 'package:base_project/app/handelers/api_exception.dart';
import 'package:base_project/app/modules/login/data/login_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:base_project/app/common_widgets/common_button.dart';
import 'package:base_project/app/common_widgets/common_textfield.dart';
import 'package:base_project/app/constants/app_strings.dart';
import 'package:base_project/app/modules/login/controller/login_controller.dart';
import 'package:base_project/app/routes/app_routes.dart';
import 'package:base_project/app/constants/enums.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final loginController = context.read<LoginController>();

      await loginController.loginUser(
        request: LoginRequestData(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );

      final response = loginController.loginResponse;
      if (!mounted) return;
      if (response.status == Status.COMPLETED) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ExceptionHandler.handleUiException(
          context: context,
          status: response.status,
          message: response.message ?? 'Login failed',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<LoginController>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.login)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CommonTextField(
                controller: _emailController,
                hintText: AppStrings.email,
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value != null && value.contains('@') ? null : 'Enter a valid email',
              ),
              const SizedBox(height: 16),
              CommonTextField(
                controller: _passwordController,
                hintText: AppStrings.password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) =>
                    value != null && value.length >= 6 ? null : 'Password must be at least 6 characters',
              ),
              const SizedBox(height: 20),
              CommonButton(
                title: AppStrings.login,
                isLoading: loginController.loginResponse.status == Status.LOADING,
                onTap: () => _login(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
