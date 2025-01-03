import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_crm/utils/urls/app_urls.dart';
import 'package:new_crm/view_models/account/account_view_model.dart';

class AccountViewModel {
  Future<bool> createAccount(AccountModel account) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrls.accountUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(account.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Error: ${response.statusCode}, Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
