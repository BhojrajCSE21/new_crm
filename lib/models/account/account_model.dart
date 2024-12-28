class AccountModel {
  String? accountOwner;
  String? accountName;
  String? accountNumber;
  String? accountSite;
  String? parentAccount;
  String? accountType;
  String? industry;
  String? mobile;
  String? fax;
  String? website;
  String? annualRevenue;
  String? tickerSymbol;
  String? ownership;
  String? employees;
  String? sicCode;
  String? rating;
  String? billingStreet;
  String? billingCity;
  String? billingZipCode;
  String? billingState;
  String? billingCountry;
  String? shippingStreet;
  String? shippingCity;
  String? shippingZipCode;
  String? shippingState;
  String? shippingCountry;
  String? description;

  AccountModel({
    this.accountOwner,
    this.accountName,
    this.accountNumber,
    this.accountSite,
    this.parentAccount,
    this.accountType,
    this.industry,
    this.mobile,
    this.fax,
    this.website,
    this.annualRevenue,
    this.tickerSymbol,
    this.ownership,
    this.employees,
    this.sicCode,
    this.rating,
    this.billingStreet,
    this.billingCity,
    this.billingZipCode,
    this.billingState,
    this.billingCountry,
    this.shippingStreet,
    this.shippingCity,
    this.shippingZipCode,
    this.shippingState,
    this.shippingCountry,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "account_owner": accountOwner,
      "account_name": accountName,
      "account_number": accountNumber,
      "account_site": accountSite,
      "parent_account": parentAccount,
      "account_type": accountType,
      "industry": industry,
      "mobile": mobile,
      "fax": fax,
      "website": website,
      "annual_revenue": annualRevenue,
      "ticker_symbol": tickerSymbol,
      "ownership": ownership,
      "employees": employees,
      "sic_code": sicCode,
      "rating": rating,
      "billing_street": billingStreet,
      "billing_city": billingCity,
      "billing_zip_code": billingZipCode,
      "billing_state": billingState,
      "billing_country": billingCountry,
      "shipping_street": shippingStreet,
      "shipping_city": shippingCity,
      "shipping_zip_code": shippingZipCode,
      "shipping_state": shippingState,
      "shipping_country": shippingCountry,
      "description": description,
    };
  }
}
