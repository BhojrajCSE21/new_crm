import 'package:flutter/material.dart';
import 'package:new_crm/models/contact/contact_model.dart';
import 'package:new_crm/view_models/contact/contact_view_model.dart';

class NewContactScreen extends StatefulWidget {
  @override
  _NewContactScreenState createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final ContactModel _contact = ContactModel();
  final ContactViewModel _contactViewModel = ContactViewModel();

  // Controllers for each field
  final TextEditingController _salutationController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _assistantController = TextEditingController();
  final TextEditingController _assistantPhoneController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _mailingStreetController = TextEditingController();
  final TextEditingController _mailingCityController = TextEditingController();
  final TextEditingController _mailingZipCodeController = TextEditingController();
  final TextEditingController _mailingStateController = TextEditingController();
  final TextEditingController _mailingCountryController = TextEditingController();
  final TextEditingController _otherStreetController = TextEditingController();
  final TextEditingController _otherCityController = TextEditingController();
  final TextEditingController _otherZipCodeController = TextEditingController();
  final TextEditingController _otherStateController = TextEditingController();
  final TextEditingController _otherCountryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactOwnerController = TextEditingController();
  final TextEditingController _leadSourceController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up memory
    _salutationController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _mobileController.dispose();
    _faxController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _titleController.dispose();
    _departmentController.dispose();
    _dateOfBirthController.dispose();
    _assistantController.dispose();
    _assistantPhoneController.dispose();
    _accountNameController.dispose();
    _mailingStreetController.dispose();
    _mailingCityController.dispose();
    _mailingZipCodeController.dispose();
    _mailingStateController.dispose();
    _mailingCountryController.dispose();
    _otherStreetController.dispose();
    _otherCityController.dispose();
    _otherZipCodeController.dispose();
    _otherStateController.dispose();
    _otherCountryController.dispose();
    _descriptionController.dispose();
    _contactOwnerController.dispose();
    _leadSourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Create New Contact",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Salutation",
                controller: _salutationController,
              ),
              _buildTextField(
                label: "First Name",
                controller: _firstNameController,
                validator: (value) => value!.isEmpty ? "First Name is required" : null,
              ),
              _buildTextField(
                label: "Last Name",
                controller: _lastNameController,
              ),
              _buildTextField(
                label: "Company Name",
                controller: _companyNameController,
              ),
              _buildTextField(
                label: "Mobile",
                controller: _mobileController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: "Fax",
                controller: _faxController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                label: "Website",
                controller: _websiteController,
              ),
              _buildTextField(
                label: "Title",
                controller: _titleController,
              ),
              _buildTextField(
                label: "Department",
                controller: _departmentController,
              ),
              _buildTextField(
                label: "Date of Birth (YYYY-MM-DD)",
                controller: _dateOfBirthController,
                keyboardType: TextInputType.datetime,
              ),
              _buildTextField(
                label: "Assistant",
                controller: _assistantController,
              ),
              _buildTextField(
                label: "Assistant Phone",
                controller: _assistantPhoneController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: "Account Name",
                controller: _accountNameController,
              ),
              _buildTextField(
                label: "Mailing Street",
                controller: _mailingStreetController,
              ),
              _buildTextField(
                label: "Mailing City",
                controller: _mailingCityController,
              ),
              _buildTextField(
                label: "Mailing Zip Code",
                controller: _mailingZipCodeController,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: "Mailing State",
                controller: _mailingStateController,
              ),
              _buildTextField(
                label: "Mailing Country",
                controller: _mailingCountryController,
              ),
              _buildTextField(
                label: "Other Street",
                controller: _otherStreetController,
              ),
              _buildTextField(
                label: "Other City",
                controller: _otherCityController,
              ),
              _buildTextField(
                label: "Other Zip Code",
                controller: _otherZipCodeController,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: "Other State",
                controller: _otherStateController,
              ),
              _buildTextField(
                label: "Other Country",
                controller: _otherCountryController,
              ),
              _buildTextField(
                label: "Description",
                controller: _descriptionController,
                maxLines: 3,
              ),
              _buildTextField(
                label: "Contact Owner",
                controller: _contactOwnerController,
              ),
              _buildTextField(
                label: "Lead Source",
                controller: _leadSourceController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _saveContactData();
                    final success = await _contactViewModel.createContact(_contact);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Contact created successfully!")),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to create contact.")),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save Contact",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  void _saveContactData() {
    _contact.salutation = _salutationController.text;
    _contact.firstName = _firstNameController.text;
    _contact.lastName = _lastNameController.text;
    _contact.companyName = _companyNameController.text;
    _contact.mobile = _mobileController.text;
    _contact.fax = _faxController.text;
    _contact.email = _emailController.text;
    _contact.website = _websiteController.text;
    _contact.title = _titleController.text;
    _contact.department = _departmentController.text;
    _contact.dateOfBirth = _dateOfBirthController.text;
    _contact.assistant = _assistantController.text;
    _contact.assistantPhone = _assistantPhoneController.text;
    _contact.accountName = _accountNameController.text;
    _contact.mailingStreet = _mailingStreetController.text;
    _contact.mailingCity = _mailingCityController.text;
    _contact.mailingZipCode = _mailingZipCodeController.text;
    _contact.mailingState = _mailingStateController.text;
    _contact.mailingCountry = _mailingCountryController.text;
    _contact.otherStreet = _otherStreetController.text;
    _contact.otherCity = _otherCityController.text;
    _contact.otherZipCode = _otherZipCodeController.text;
    _contact.otherState = _otherStateController.text;
    _contact.otherCountry = _otherCountryController.text;
    _contact.description = _descriptionController.text;
    _contact.contactOwner = _contactOwnerController.text;
    _contact.leadSource = _leadSourceController.text;
  }
}
