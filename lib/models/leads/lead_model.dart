class NewLeadModel {
  String? salutation;
  String? firstName;
  String? lastName;
  String? designation;
  String? companyName;
  String? dateOfVisit;
  String? industry;
  String? mobile;
  String? email;
  String? website;
  String? leadStatus;
  String? rating;
  String? productInterest;
  String? leadSource;
  String? keyPersonPresent;
  String? street;
  String? city;
  String? zipCode;
  String? state;
  String? country;
  String? objective;
  String? descripition;
  String? duration;

  NewLeadModel({
    this.salutation,
    this.firstName,
    this.lastName,
    this.designation,
    this.companyName,
    this.dateOfVisit,
    this.industry,
    this.mobile,
    this.email,
    this.website,
    this.leadStatus,
    this.rating,
    this.productInterest,
    this.leadSource,
    this.keyPersonPresent,
    this.street,
    this.city,
    this.zipCode,
    this.state,
    this.country,
    this.objective,
    this.descripition,
    this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "salutation": salutation,
      "first_name": firstName,
      "last_name": lastName,
      "designation": designation,
      "company_name": companyName,
      "date_of_visit": dateOfVisit, // Ensure this is formatted correctly
      "industry": industry,
      "mobile": mobile,
      "email": email,
      "website": website,
      "lead_status": leadStatus,
      "rating": rating,
      "product_interest": productInterest,
      "lead_source": leadSource,
      "key_person_present": keyPersonPresent,
      "street": street,
      "city": city,
      "zip_code": zipCode,
      "state": state,
      "country": country,
      "objective": objective,
      "descripition": descripition, // Fixed typo here
      "duration": duration,
    };
  }
}
