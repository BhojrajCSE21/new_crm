import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_crm/models/login_model.dart';
import 'package:new_crm/utils/general/utils.dart';
import 'package:new_crm/view/auth/login_screen.dart';
import 'package:new_crm/view/dashboard/screens/home_view.dart';

class LoginViewModel with ChangeNotifier {
  final loginService = LoginApiService();
  final _secureStorage = const FlutterSecureStorage();

  String? _userName;
  String? _password;
  bool _isAuthenticated = false;

  String? get userName => _userName;
  String? get password => _password;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> loginApi(BuildContext context, Map<String, dynamic> data) async {
    try {
      final loginResponse = await loginService.loginApi(context, data);

      if (loginResponse != null) {
        _userName = data['username'];
        _password = data['password'];
        _isAuthenticated = true;

        await _secureStorage.write(key: 'username', value: _userName);
        await _secureStorage.write(key: 'password', value: _password);

        notifyListeners();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (error) {
      Utils.flushbarErrorMessage("An error occurred during login: $error", context);
    }
  }

  Future<void> loadUserData() async {
    _userName = await _secureStorage.read(key: 'username') ?? "";
    _password = await _secureStorage.read(key: 'password') ?? "";
    notifyListeners();
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      await _secureStorage.deleteAll();
      _userName = null;
      _password = null;
      _isAuthenticated = false;

      notifyListeners();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (error) {
      Utils.flushbarErrorMessage("An error occurred during logout: $error", context);
    }
  }
}
