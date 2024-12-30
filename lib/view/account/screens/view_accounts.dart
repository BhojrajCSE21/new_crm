import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For a loading spinner
import 'package:new_crm/utils/urls/app_urls.dart';
import 'package:new_crm/view/contact/widgets/activities_tab.dart';
import 'package:new_crm/view/contact/widgets/connection_tab.dart';

class ViewAccountsScreen extends StatefulWidget {
  const ViewAccountsScreen({super.key});

  @override
  _ViewAccountsScreenState createState() => _ViewAccountsScreenState();
}

class _ViewAccountsScreenState extends State<ViewAccountsScreen> {
  late Future<List<Map<String, dynamic>>> _accountsFuture;

  Future<List<Map<String, dynamic>>> _fetchAccounts() async {
    final response = await http.get(Uri.parse(AppUrls.accountUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> accounts = data['Contacts'] ?? [];
      return accounts.cast<Map<String, dynamic>>(); // Cast to List<Map<String, dynamic>>
    } else {
      throw Exception('Failed to load accounts');
    }
  }

  @override
  void initState() {
    super.initState();
    _accountsFuture = _fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Accounts'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _accountsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitCircle(color: Colors.blue, size: 50.0),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No accounts available.'));
          }

          final accounts = snapshot.data!;
          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    account['account_name'] ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    account['industry'] ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountDetailsScreen(
                          accountId: account['id'].toString(),
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

class AccountDetailsScreen extends StatelessWidget {
  final String accountId;

  const AccountDetailsScreen({super.key, required this.accountId});

  Future<Map<String, dynamic>> _fetchAccountDetails() async {
    final url = AppUrls.individualAccountUrl(accountId); // Fetch dynamic URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load account details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchAccountDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(color: Colors.blue, size: 50.0),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Account Details')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final account = snapshot.data!;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(account['account_name'] ?? 'Account Details'),
            ),
            body: Column(
              children: [
                // Account Information Header
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
                            'Account Owner: ${account['account_owner'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.business, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text('Industry: ${account['industry'] ?? 'N/A'}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.green),
                              const SizedBox(width: 8),
                              Text('Phone: ${account['phone'] ?? 'N/A'}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.language, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text('Website: ${account['website'] ?? 'N/A'}'),
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
                      AccountDetailsTab(accountDetails: account),
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

class AccountDetailsTab extends StatelessWidget {
  final Map<String, dynamic> accountDetails;

  const AccountDetailsTab({super.key, required this.accountDetails});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const Text(
          'Account Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Account Name: ${accountDetails['account_name']}'),
        Text('Industry: ${accountDetails['industry']}'),
        Text('Phone: ${accountDetails['phone']}'),
        Text('Website: ${accountDetails['website']}'),
        const SizedBox(height: 16),
        const Text(
          'Description Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Description: ${accountDetails['description']}'),
      ],
    );
  }
}
