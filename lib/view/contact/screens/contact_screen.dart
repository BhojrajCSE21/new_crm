import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For a loading spinner
import 'package:new_crm/utils/urls/app_urls.dart';
import 'package:new_crm/view/contact/widgets/activities_tab.dart';
import 'package:new_crm/view/contact/widgets/connection_tab.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late Future<List<Map<String, dynamic>>> _contactsFuture;

  Future<List<Map<String, dynamic>>> _fetchContacts() async {
    final response = await http.get(Uri.parse(AppUrls.contactUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> contacts = data['Contacts'] ?? [];
      return contacts
          .cast<Map<String, dynamic>>(); // Cast to List<Map<String, dynamic>>
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  @override
  void initState() {
    super.initState();
    _contactsFuture = _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _contactsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitCircle(color: Colors.blue, size: 50.0),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts available.'));
          }

          final contacts = snapshot.data!;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    '${contact['salutation']} ${contact['first_name']} ${contact['last_name']}' ??
                        '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    contact['company_name'] ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetailsScreen(
                          contactId:
                              contact['id'].toString(), // Pass contact ID
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final String contactId;

  const ContactDetailsScreen({super.key, required this.contactId});

  Future<Map<String, dynamic>> _fetchContactDetails() async {
    final url = AppUrls.individualContactUrl(contactId); // Fetch dynamic URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load contact details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchContactDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(color: Colors.blue, size: 50.0),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Contact Details')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final contact = snapshot.data!;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${contact['salutation']} ${contact['first_name']} ${contact['last_name']}',
              ),
            ),
            body: Column(
              children: [
                // Contact Information Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Owner: ${contact['contact_owner'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.email, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text('Email: ${contact['email'] ?? 'N/A'}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.green),
                              const SizedBox(width: 8),
                              Text('Phone: ${contact['mobile'] ?? 'N/A'}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.apartment, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text(
                                  'Department: ${contact['department'] ?? 'N/A'}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.blue,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(text: 'Activities'),
                    Tab(text: 'Details'),
                    Tab(text: 'Connections'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const ActivitiesTab(), // Call ActivitiesTab
                      DetailsTab(contactDetails: contact),
                      const ConnectionsTab(), // Call ConnectionsTab
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DetailsTab extends StatelessWidget {
  final Map<String, dynamic> contactDetails;

  const DetailsTab({super.key, required this.contactDetails});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
            'Name: ${contactDetails['first_name']} ${contactDetails['last_name']}'),
        Text('Company Name: ${contactDetails['company_name']}'),
        Text('Date of Birth: ${contactDetails['date_of_birth']}'),
        Text('Mobile: ${contactDetails['mobile']}'),
        Text('Email: ${contactDetails['email']}'),
        Text('Website: ${contactDetails['website']}'),
        Text('Department: ${contactDetails['department']}'),
        const SizedBox(height: 16),
        const Text(
          'Address Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Mailing Address: ${contactDetails['mailing_street']}'),
        const SizedBox(height: 16),
        const Text(
          'Description Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Description: ${contactDetails['description']}'),
      ],
    );
  }
}
