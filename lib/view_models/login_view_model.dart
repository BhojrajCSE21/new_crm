import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_crm/utils/general/secure_storage.dart';
import 'package:new_crm/utils/urls/app_urls.dart';
import '../models/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final SecureStorage _secureStorage = SecureStorage();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(AppUrls.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            LoginRequest(username: username, password: password).toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract the access token from the response
        final accessToken = data['access'];

        // Store the access token in secure storage
        await _secureStorage.writeToken(accessToken);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
