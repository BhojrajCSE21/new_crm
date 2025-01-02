import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_crm/models/leads/lead_model.dart';
import 'package:new_crm/utils/urls/app_urls.dart';

class NewLeadViewModel {
  Future<bool> createLead(NewLeadModel newLead) async {
    final url = Uri.parse(AppUrls.leadURL);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newLead.toJson()),
      );

      if (response.statusCode == 201) {
        print("Lead created successfully.");
        return true;
      } else {
        print("Failed to create lead: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error creating lead: $e");
      return false;
    }
  }
}
