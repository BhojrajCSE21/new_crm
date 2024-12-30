import 'package:flutter/material.dart';
import 'package:new_crm/models/account/account_model.dart';
import 'package:new_crm/view_models/account/account_view_model.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  _NewAccountScreenState createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final AccountModel _account = AccountModel();
  final AccountViewModel _accountViewModel = AccountViewModel();

  // Controllers for text fields
  final TextEditingController _accountOwnerController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountSiteController = TextEditingController();
  final TextEditingController _parentAccountController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _annualRevenueController = TextEditingController();
  final TextEditingController _tickerSymbolController = TextEditingController();
  final TextEditingController _billingStreetController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingZipCodeController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingCountryController = TextEditingController();
  final TextEditingController _shippingStreetController = TextEditingController();
  final TextEditingController _shippingCityController = TextEditingController();
  final TextEditingController _shippingZipCodeController = TextEditingController();
  final TextEditingController _shippingStateController = TextEditingController();
  final TextEditingController _shippingCountryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sicCodeController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  // Dropdown options
  final List<String> _industries = [
    '--None--',
    'Agriculture',
    'Defence&Security',
    'Forestry',
    'Water Resources',
    'Mining&Mineral Resource Mapping',
    'Mapping&Land Administration',
    'Urban Development&Infrastructure',
    'Oil&Gas',
    'Others..'
  ];

  final List<String> _accountTypes = [
    '--None--',
    'Analyst',
    'Competitor',
    'Customer',
    'Customer-Channel',
    'Distributor',
    'Integrator',
    'Investor',
    'Installation Partner',
    'Partner',
    'Press',
    'Prospect',
    'Reseller/Channel Partner',
    'Supplier',
    'Technology partner',
    'Vendor',
    'Others..'
  ];

  final List<String> _ownerships = [
    '--None--',
    'Private',
    'Public',
    'Subsidiary',
    'Partnership',
    'Government',
    'Others..'
  ];

  final List<String> _employees = [
    '--None--',
    '1-10',
    '10-50',
    '50-100',
    '100-200',
    '200-500',
    '500 above'
  ];

  // State for dropdowns
  String? _selectedAccountType = '--None--';
  String? _selectedIndustry = '--None--';
  String? _selectedOwnership = '--None--';
  String? _selectedEmployees = '--None--';

  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data from controllers to model
      _account.accountOwner = _accountOwnerController.text;
      _account.accountName = _accountNameController.text;
      _account.accountNumber = _accountNumberController.text;
      _account.accountSite = _accountSiteController.text;
      _account.parentAccount = _parentAccountController.text;
      _account.mobile = _mobileController.text;
      _account.fax = _faxController.text;
      _account.website = _websiteController.text;
      _account.annualRevenue = _annualRevenueController.text;
      _account.tickerSymbol = _tickerSymbolController.text;
      _account.billingStreet = _billingStreetController.text;
      _account.billingCity = _billingCityController.text;
      _account.billingZipCode = _billingZipCodeController.text;
      _account.billingState = _billingStateController.text;
      _account.billingCountry = _billingCountryController.text;
      _account.shippingStreet = _shippingStreetController.text;
      _account.shippingCity = _shippingCityController.text;
      _account.shippingZipCode = _shippingZipCodeController.text;
      _account.shippingState = _shippingStateController.text;
      _account.shippingCountry = _shippingCountryController.text;
      _account.description = _descriptionController.text;
      _account.sicCode = _sicCodeController.text;
      _account.rating = _ratingController.text;

      // Assign dropdown values
      _account.accountType = _selectedAccountType;
      _account.industry = _selectedIndustry;
      _account.ownership = _selectedOwnership;
      _account.employees = _selectedEmployees;

      final success = await _accountViewModel.createAccount(_account);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create account.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle('Account Information'),
              _buildTextField(label: 'Account Owner', controller: _accountOwnerController),
              _buildTextField(label: 'Account Name', controller: _accountNameController),
              _buildTextField(label: 'Account Number', controller: _accountNumberController),
              _buildTextField(label: 'Account Site', controller: _accountSiteController),
              _buildTextField(label: 'Parent Account', controller: _parentAccountController),
              _buildDropdownField(
                label: 'Account Type',
                options: _accountTypes,
                value: _selectedAccountType,
                onChanged: (value) => setState(() => _selectedAccountType = value),
              ),
              _buildDropdownField(
                label: 'Industry',
                options: _industries,
                value: _selectedIndustry,
                onChanged: (value) => setState(() => _selectedIndustry = value),
              ),
              _buildTextField(label: 'Mobile', controller: _mobileController),
              _buildTextField(label: 'Fax', controller: _faxController),
              _buildTextField(label: 'Website', controller: _websiteController),
              _buildTextField(label: 'Rating', controller: _ratingController),
              _buildTextField(label: 'Annual Revenue ₹', controller: _annualRevenueController),
              _buildTextField(label: 'Ticker Symbol', controller: _tickerSymbolController),
              _buildDropdownField(
                label: 'Ownership',
                options: _ownerships,
                value: _selectedOwnership,
                onChanged: (value) => setState(() => _selectedOwnership = value),
              ),
              _buildDropdownField(
                label: 'Employees',
                options: _employees,
                value: _selectedEmployees,
                onChanged: (value) => setState(() => _selectedEmployees = value),
              ),
              _buildTextField(label: 'SIC Code', controller: _sicCodeController),
              const SizedBox(height: 20),
              _buildSectionTitle('Address Information'),
              _buildTextField(label: 'Billing Street', controller: _billingStreetController),
              _buildTextField(label: 'Billing City', controller: _billingCityController),
              _buildTextField(label: 'Billing Zip Code', controller: _billingZipCodeController),
              _buildTextField(label: 'Billing State', controller: _billingStateController),
              _buildTextField(label: 'Billing Country', controller: _billingCountryController),
              _buildTextField(label: 'Shipping Street', controller: _shippingStreetController),
              _buildTextField(label: 'Shipping City', controller: _shippingCityController),
              _buildTextField(label: 'Shipping Zip Code', controller: _shippingZipCodeController),
              _buildTextField(label: 'Shipping State', controller: _shippingStateController),
              _buildTextField(label: 'Shipping Country', controller: _shippingCountryController),
              const SizedBox(height: 20),
              _buildSectionTitle('Description Information'),
              _buildTextField(label: 'Description', controller: _descriptionController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAccount,
                child: const Text('Save Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> options,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: options
            .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == '--None--' || value == null) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
