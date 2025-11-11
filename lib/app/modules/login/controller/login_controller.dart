import 'package:base_project/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  String _businessId = '';
  bool _rememberMe = false;
  UserModel? _selectedUser;
  String _passcode = '';
  bool _isLoading = false;
  
  String get businessId => _businessId;
  bool get rememberMe => _rememberMe;
  UserModel? get selectedUser => _selectedUser;
  String get passcode => _passcode;
  bool get isLoading => _isLoading;
  
  List<UserModel> users = [
    UserModel(id: '1', name: 'Jack Jackson', role: 'Business Owner'),
    UserModel(id: '2', name: 'Jack Jackson restaurant', role: 'Business Owner'),
    UserModel(id: '3', name: 'Jack Jackson', role: 'Business Owner'),
    UserModel(id: '4', name: 'Jack Jackson restaurant', role: 'Business Owner'),
  ];
  
  void setBusinessId(String id) {
    _businessId = id;
    notifyListeners();
  }
  
  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
  
  void selectUser(UserModel user) {
    _selectedUser = user;
    notifyListeners();
  }
  
  void addPasscodeDigit(String digit) {
    if (_passcode.length < 6) {
      _passcode += digit;
      notifyListeners();
    }
  }
  
  void removePasscodeDigit() {
    if (_passcode.isNotEmpty) {
      _passcode = _passcode.substring(0, _passcode.length - 1);
      notifyListeners();
    }
  }
  
  void clearPasscode() {
    _passcode = '';
    notifyListeners();
  }
  
  Future<bool> verifyPasscode() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 1));
    
    _isLoading = false;
    notifyListeners();
    
    return _passcode == '123456';
  }
}
