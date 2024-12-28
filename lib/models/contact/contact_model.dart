class ContactModel {
  String? salutation;
  String? firstName;
  String? lastName;
  String? companyName;
  String? mobile;
  String? fax;
  String? email;
  String? website;
  String? title;
  String? department;
  String? dateOfBirth;
  String? assistant;
  String? assistantPhone;
  String? accountName;
  String? mailingStreet;
  String? mailingCity;
  String? mailingZipCode;
  String? mailingState;
  String? mailingCountry;
  String? otherStreet;
  String? otherCity;
  String? otherZipCode;
  String? otherState;
  String? otherCountry;
  String? description;
  String? contactOwner;
  String? leadSource; // Added field

  ContactModel({
    this.salutation,
    this.firstName,
    this.lastName,
    this.companyName,
    this.mobile,
    this.fax,
    this.email,
    this.website,
    this.title,
    this.department,
    this.dateOfBirth,
    this.assistant,
    this.assistantPhone,
    this.accountName,
    this.mailingStreet,
    this.mailingCity,
    this.mailingZipCode,
    this.mailingState,
    this.mailingCountry,
    this.otherStreet,
    this.otherCity,
    this.otherZipCode,
    this.otherState,
    this.otherCountry,
    this.description,
    this.contactOwner,
    this.leadSource, // Added field
  });

  Map<String, dynamic> toJson() {
    return {
      "salutation": salutation,
      "first_name": firstName,
      "last_name": lastName,
      "company_name": companyName,
      "mobile": mobile,
      "fax": fax,
      "email": email,
      "website": website,
      "title": title,
      "department": department,
      "date_of_birth": dateOfBirth,
      "assistant": assistant,
      "assistant_phone": assistantPhone,
      "account_name": accountName,
      "mailing_street": mailingStreet,
      "mailing_city": mailingCity,
      "mailing_zip_code": mailingZipCode,
      "mailing_state": mailingState,
      "mailing_country": mailingCountry,
      "other_street": otherStreet,
      "other_city": otherCity,
      "other_zip_code": otherZipCode,
      "other_state": otherState,
      "other_country": otherCountry,
      "description": description,
      "contact-owner": contactOwner,
      "lead_source": leadSource, // Added field
    };
  }
}
