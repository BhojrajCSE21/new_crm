import 'package:flutter/material.dart';

class ConnectionsTab extends StatefulWidget {
  const ConnectionsTab({super.key});

  @override
  State<ConnectionsTab> createState() => _ConnectionsTabState();
}

class _ConnectionsTabState extends State<ConnectionsTab> {
  // Controllers for form fields
  final TextEditingController _opportunityNameController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _closingDateController = TextEditingController();
  final TextEditingController _probabilityController = TextEditingController();
  final TextEditingController _campaignSourceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dropdown values
  String _selectedType = 'New Business';
  String _selectedLeadSource = '--None--';
  String _selectedStage = '--None--';

  // Options for dropdowns
  final List<String> _typeOptions = [
    'New Business',
    'Existing Business',
    'Existing Business-Upgrade',
    'Existing Business-Replacement',
    'Existing Business-Downgrade',
  ];

  final List<String> _leadSourceOptions = [
    '--None--',
    'Advertisment',
    'Chat',
    'Cold Call',
    'Employee Referral',
    'External Referral',
    'Partner',
    'Public Relations',
    'Phone Inquiry',
    'Seminar Partner',
    'Internal Seminar',
    'Tradeshow',
    'Web Download',
    'Web Research',
    'Other',
  ];

  final List<String> _stageOptions = [
    '--None--',
    'Qualification',
    'Need Analysis',
    'Value Proposition',
    'Identify Decision Makers',
    'Perception Analysis',
    'Proposal/Price Quote',
    'Negotiation/Review',
    'Closed Won',
    'Closed Lost',
  ];

  // Show the form dialog for "New Opportunity"
  void _showNewOpportunityForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'New Opportunity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Opportunity Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _opportunityNameController,
                  decoration: const InputDecoration(
                    labelText: 'Opportunity Name',
                    hintText: 'Enter opportunity name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount ₹',
                    hintText: 'Enter amount',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _accountNameController,
                  decoration: const InputDecoration(
                    labelText: 'Account Name',
                    hintText: 'Enter account name',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: _typeOptions
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Type',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLeadSource,
                  items: _leadSourceOptions
                      .map((source) =>
                          DropdownMenuItem(value: source, child: Text(source)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLeadSource = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Lead Source',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _closingDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Closing Date',
                    hintText: 'mm/dd/yyyy',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _closingDateController.text =
                                '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStage,
                  items: _stageOptions
                      .map((stage) =>
                          DropdownMenuItem(value: stage, child: Text(stage)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStage = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Stage',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _probabilityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Probability (%)',
                    hintText: 'Enter probability',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _campaignSourceController,
                  decoration: const InputDecoration(
                    labelText: 'Campaign Source',
                    hintText: 'Enter campaign source',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromRGBO(29, 78, 216, 1),
              ),
              onPressed: () {
                // Add save logic here
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: const Text('Opportunity'),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromRGBO(29, 78, 216, 1),
            ),
            onPressed: _showNewOpportunityForm,
            child: const Text('New'),
          ),
        ),
        ListTile(
          title: const Text('Campaigns'),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromRGBO(29, 78, 216, 1),
            ),
            onPressed: () {},
            child: const Text('Add Campaign'),
          ),
        ),
        ListTile(
          title: const Text('Attachments & Notes'),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromRGBO(29, 78, 216, 1),
            ),
            onPressed: () {},
            child: const Text('Upload Files'),
          ),
        ),
      ],
    );
  }
}
