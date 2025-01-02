class AppUrls {
  static var baseUrl = "http://192.168.1.181:8200";
  static var loginUrl = "$baseUrl/login/";
  static var leadURL = "$baseUrl/user/admin/lead/";
  static var contactUrl = "$baseUrl/user/admin/contacts/";
  static var accountUrl = "$baseUrl/user/admin/accounts/";

  // Method to generate URL for individual contact
  static String individualContactUrl(String contactId) {
    return '$baseUrl/contact/$contactId/';
  }

  // Updated method to generate URL for individual account
  static String individualAccountUrl(String username, String accountId) {
    return '$baseUrl/user/$username/accounts/$accountId';
  }
}
