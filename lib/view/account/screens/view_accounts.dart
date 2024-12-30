import 'package:flutter/material.dart';

class ViewAccountsScreen extends StatelessWidget {
  const ViewAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Accounts'),
      ),
      body: Center(
        child: Text(
          'List of accounts will be displayed here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
