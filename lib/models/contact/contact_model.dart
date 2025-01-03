import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_crm/utils/urls/app_urls.dart';
import 'package:new_crm/view_models/contact/contact_view_model.dart';

class ContactModel {
  Future<bool> createContact(ContactViewModel contact) async {
    final url = Uri.parse(AppUrls.contactUrl);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      // Contact created successfully
      return true;
    } else {
      // Handle error
      print("Failed to create contact: ${response.body}");
      return false;
    }
  }
}
