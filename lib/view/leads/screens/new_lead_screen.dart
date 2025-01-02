import 'package:flutter/material.dart';
import 'package:new_crm/models/leads/lead_model.dart';
import 'package:intl/intl.dart';
import 'package:new_crm/view_models/leads/lead_view_model.dart'; // For date formatting

class NewLeadView extends StatefulWidget {
  const NewLeadView({super.key});

  @override
  _NewLeadViewState createState() => _NewLeadViewState();
}

class _NewLeadViewState extends State<NewLeadView> {
  final _formKey = GlobalKey<FormState>();
  final NewLeadModel _newLeadModel = NewLeadModel();
  final NewLeadViewModel _newLeadViewModel = NewLeadViewModel();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _dateOfVisitController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _leadStatusController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _productInterestController =
      TextEditingController();
  final TextEditingController _leadSourceController = TextEditingController();
  final TextEditingController _keyPersonPresentController =
      TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _descripitionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Dropdown options
  final List<String> _salutations = [
    '--None--',
    'Mr.',
    'Ms.',
    'Mrs.',
    'Dr.',
    'Prof.'
  ];
  String _selectedSalutation = '--None--';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Lead"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionHeader("Lead Information"),
              _buildDropdownField(
                label: "Salutation",
                value: _selectedSalutation,
                items: _salutations,
                onChanged: (value) =>
                    setState(() => _selectedSalutation = value!),
              ),
              _buildTextField(
                  label: "First Name", controller: _firstNameController),
              _buildTextField(
                  label: "Last Name", controller: _lastNameController),
              _buildTextField(
                  label: "Designation", controller: _designationController),
              _buildTextField(
                  label: "Company Name", controller: _companyNameController),
              _buildTextField(
                  label: "Mobile",
                  controller: _mobileController,
                  keyboardType: TextInputType.phone),
              _buildTextField(
                  label: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField(label: "Website", controller: _websiteController),
              _buildTextField(
                  label: "Date of Visit (YYYY-MM-DD)",
                  controller: _dateOfVisitController,
                  keyboardType: TextInputType.datetime),
              _buildTextField(
                  label: "Industry", controller: _industryController),
              _buildTextField(
                  label: "Lead Source", controller: _leadSourceController),
              _buildTextField(
                  label: "Lead Status", controller: _leadStatusController),
              _buildTextField(label: "Rating", controller: _ratingController),
              _buildTextField(
                  label: "Product Interest",
                  controller: _productInterestController),
              _buildTextField(
                  label: "Key Person Present",
                  controller: _keyPersonPresentController),
              _buildTextField(label: "Street", controller: _streetController),
              _buildTextField(label: "City", controller: _cityController),
              _buildTextField(
                  label: "Zip Code",
                  controller: _zipCodeController,
                  keyboardType: TextInputType.number),
              _buildTextField(label: "State", controller: _stateController),
              _buildTextField(label: "Country", controller: _countryController),
              const SizedBox(height: 16),
              _buildSectionHeader("Description"),
              _buildTextField(
                  label: "Description",
                  controller: _descripitionController,
                  maxLines: 3),
              _buildTextField(
                  label: "Duration", controller: _durationController),
              _buildTextField(
                  label: "Objective", controller: _objectiveController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveLead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Save Lead",
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  void _saveLead() async {
    if (_formKey.currentState!.validate()) {
      _newLeadModel.salutation = _selectedSalutation;
      _newLeadModel.firstName = _firstNameController.text;
      _newLeadModel.lastName = _lastNameController.text;
      _newLeadModel.designation = _designationController.text;
      _newLeadModel.companyName = _companyNameController.text;
      _newLeadModel.dateOfVisit = _formatDate(_dateOfVisitController.text);
      _newLeadModel.industry = _industryController.text;
      _newLeadModel.mobile = _mobileController.text;
      _newLeadModel.email = _emailController.text;
      _newLeadModel.website = _websiteController.text;
      _newLeadModel.leadStatus = _leadStatusController.text;
      _newLeadModel.rating = _ratingController.text;
      _newLeadModel.productInterest = _productInterestController.text;
      _newLeadModel.leadSource = _leadSourceController.text;
      _newLeadModel.keyPersonPresent = _keyPersonPresentController.text;
      _newLeadModel.street = _streetController.text;
      _newLeadModel.city = _cityController.text;
      _newLeadModel.zipCode = _zipCodeController.text;
      _newLeadModel.state = _stateController.text;
      _newLeadModel.country = _countryController.text;
      _newLeadModel.objective = _objectiveController.text;
      _newLeadModel.descripition = _descripitionController.text;
      _newLeadModel.duration = _durationController.text;

      final success = await _newLeadViewModel.createLead(_newLeadModel);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lead created successfully!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create lead.")),
        );
      }
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(parsedDate);
    } catch (e) {
      print("Error formatting date: $e");
      return date; // Return the original date if parsing fails
    }
  }
}
