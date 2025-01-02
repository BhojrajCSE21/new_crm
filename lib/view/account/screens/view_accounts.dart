import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  // Fetch accounts data from the API
  Future<List<Map<String, dynamic>>> _fetchAccounts() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.accountUrl));
      print('Fetching accounts from: ${AppUrls.accountUrl}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data');
        List<dynamic> accounts = data['Contacts'] ?? []; // Adjust key to match API response
        return accounts.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load accounts');
      }
    } catch (e) {
      throw Exception('Error fetching accounts: $e');
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
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _accountsFuture = _fetchAccounts(); // Refresh the data
              });
            },
            child: ListView.builder(
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
            ),
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
    final url = AppUrls.individualAccountUrl(accountId);
    print('Fetching account details from URL: $url');
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load account details');
      }
    } catch (e) {
      throw Exception('Error fetching account details: $e');
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Owner: ${account['account_owner'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Industry: ${account['industry'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Phone: ${account['phone'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'Activities'),
                    Tab(text: 'Details'),
                    Tab(text: 'Connections'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const ActivitiesTab(),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Number: ${account['account_number'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            // Add more details as needed
                          ],
                        ),
                      ),
                      const ConnectionsTab(),
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
