import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeadsPage(),
    );
  }
}
class LeadsPage extends StatelessWidget {
  // Sample data for leads
  final List<Map<String, String>> leads = [
    {'name': 'Raju Bhai', 'company': 'Sadada'},
    {'name': 'Aniket', 'company': 'ACE'},
    {'name': 'John Doe', 'company': 'Tech Co.'},
    {'name': 'Sara Smith', 'company': 'InnovateX'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leads'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.black54),
                        SizedBox(width: 8),
                        Text(
                          'Leads',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage potential customers',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // List of Leads with Name and Company
          Expanded(
            child: ListView.builder(
              itemCount: leads.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      leads[index]['name']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      leads[index]['company']!,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle onTap action if needed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped on ${leads[index]['name']}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
