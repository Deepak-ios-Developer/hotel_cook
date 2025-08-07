import 'package:base_project/app/common_widgets/print_widget.dart';
import 'package:base_project/app/constants/enums.dart';
import 'package:base_project/app/constants/keys.dart';
import 'package:base_project/app/handelers/api_response.dart';
import 'package:base_project/app/modules/login/data/login_data.dart';
import 'package:base_project/app/modules/login/service/login_service.dart';
import 'package:base_project/app/storage/app_storage.dart';
import 'package:base_project/service/base_service.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  String email = '';
  String password = '';

  ApiResponse _loginResponse = ApiResponse.initial('Login not initiated');
  ApiResponse get loginResponse => _loginResponse;


  final LoginService _loginService = LoginService();
  final AppStorage _appStorage = AppStorage();


  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }


Future<void> loginUser({ LoginRequestData? request
}) async {
  _loginResponse = ApiResponse.loading("Logging in...");
  notifyListeners();
  try {
    final response = await _loginService.login(request!);
    final loginData = LoginResponseData.fromJson(response[Keys.data]);
    final apiStatus = loginData.status?.toApiStatus();
    if (apiStatus == ApiStatus.success200) {
      // Save token using SessionManager
      _appStorage.setToken(loginData.token ?? '');
      _loginResponse = ApiResponse.completed(loginData);
    } else {
      _loginResponse = ApiResponse.error(
        'Login failed: ${loginData.message ?? 'Unknown error'}',
      );
      printDebug('Login error: ${loginData.message}');
    }
  } catch (e) {
    _loginResponse = ApiResponse.error(e.toString());
    printDebug('Exception occurred: $e');
  }
  notifyListeners();
}

  











}
