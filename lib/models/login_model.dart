import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:new_crm/utils/urls/app_urls.dart';
import 'package:new_crm/utils/general/utils.dart';

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class LoginModel {
  final String token;

  LoginModel({required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('access') || json['access'] == null) {
      throw FormatException("Missing or null 'access' field in response");
    }
    return LoginModel(
      token: json['access'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': token,
    };
  }
}

class LoginApiService {
  final _storage = const FlutterSecureStorage();

  Future<LoginModel?> loginApi(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.loginUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        final loginModel = LoginModel.fromJson(responseBody);

        await _storage.write(key: 'jwt_token', value: loginModel.token);
        return loginModel;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        Utils.flushbarErrorMessage("Invalid Username or Password", context);
      } else {
        Utils.flushbarErrorMessage(
            "Something went wrong. Please try again later.", context);
      }
    } on TimeoutException {
      Utils.flushbarErrorMessage(
          "Request timed out. Please try again.", context);
    } on SocketException {
      Utils.flushbarErrorMessage("No Internet Connection", context);
    } catch (e) {
      Utils.flushbarErrorMessage("Error Occurred: $e", context);
    }
    return null;
  }
}
