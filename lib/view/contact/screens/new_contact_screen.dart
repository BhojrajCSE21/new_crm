import 'package:flutter/material.dart';
import 'package:new_crm/view_models/contact/contact_view_model.dart';
import 'package:new_crm/models/contact/contact_model.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  _NewContactScreenState createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final ContactViewModel _contact = ContactViewModel();
  final ContactModel _contactModel = ContactModel();

  // TextEditingControllers for each field
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
  final TextEditingController _assistantPhoneController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _mailingStreetController =
      TextEditingController();
  final TextEditingController _mailingCityController = TextEditingController();
  final TextEditingController _mailingZipCodeController =
      TextEditingController();
  final TextEditingController _mailingStateController = TextEditingController();
  final TextEditingController _mailingCountryController =
      TextEditingController();
  final TextEditingController _otherStreetController = TextEditingController();
  final TextEditingController _otherCityController = TextEditingController();
  final TextEditingController _otherZipCodeController = TextEditingController();
  final TextEditingController _otherStateController = TextEditingController();
  final TextEditingController _otherCountryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _leadSourceController = TextEditingController();
  final TextEditingController _contactOwnerController = TextEditingController();

  String? _selectedSalutation = '--None--';
  final List<String> _salutations = ['--None--', 'Mr.', 'Ms.', 'Mrs.', 'Prof.'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionHeader("Contact Information"),
              _buildDropdownField(
                label: "Salutation",
                value: _selectedSalutation,
                items: _salutations,
                onChanged: (value) {
                  setState(() {
                    _selectedSalutation = value;
                  });
                },
              ),
              _buildTextField(label: "First Name", controller: _firstNameController),
              _buildTextField(label: "Last Name", controller: _lastNameController),
              _buildTextField(label: "Company Name", controller: _companyNameController),
              _buildTextField(label: "Mobile", controller: _mobileController, keyboardType: TextInputType.phone),
              _buildTextField(label: "Fax", controller: _faxController, keyboardType: TextInputType.phone),
              _buildTextField(label: "Email", controller: _emailController, keyboardType: TextInputType.emailAddress),
              _buildTextField(label: "Website", controller: _websiteController),
              _buildTextField(label: "Account Name", controller: _accountNameController),
              _buildTextField(label: "Title", controller: _titleController),
              _buildTextField(label: "Department", controller: _departmentController),
              _buildTextField(label: "Date of Birth (YYYY-MM-DD)", controller: _dateOfBirthController, keyboardType: TextInputType.datetime),
              _buildTextField(label: "Assistant", controller: _assistantController),
              _buildTextField(label: "Assistant Phone", controller: _assistantPhoneController, keyboardType: TextInputType.phone),

              _buildSectionHeader("Address Information"),
              _buildTextField(label: "Mailing Street", controller: _mailingStreetController),
              _buildTextField(label: "Mailing City", controller: _mailingCityController),
              _buildTextField(label: "Mailing Zip Code", controller: _mailingZipCodeController, keyboardType: TextInputType.number),
              _buildTextField(label: "Mailing State", controller: _mailingStateController),
              _buildTextField(label: "Mailing Country", controller: _mailingCountryController),
              _buildTextField(label: "Other Street", controller: _otherStreetController),
              _buildTextField(label: "Other City", controller: _otherCityController),
              _buildTextField(label: "Other Zip Code", controller: _otherZipCodeController, keyboardType: TextInputType.number),
              _buildTextField(label: "Other State", controller: _otherStateController),
              _buildTextField(label: "Other Country", controller: _otherCountryController),

              _buildSectionHeader("Description Information"),
              _buildTextField(label: "Description", controller: _descriptionController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text("Save Contact"),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _saveContact() async {
    if (_formKey.currentState!.validate()) {
      // Assigning all form values to the ContactViewModel
      _contact.salutation = _selectedSalutation == '--None--' ? null : _selectedSalutation;
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
      _contact.leadSource = _leadSourceController.text;
      _contact.contactOwner = _contactOwnerController.text;

      final success = await _contactModel.createContact(_contact);

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
  }
}
