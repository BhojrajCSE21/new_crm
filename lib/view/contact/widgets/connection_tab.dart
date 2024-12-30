import 'package:flutter/material.dart';

class ConnectionsTab extends StatelessWidget {
  const ConnectionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ListTile(
          title: const Text('Opportunity'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('New'),
          ),
        ),
        ListTile(
          title: const Text('Campaigns'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Add Campaign'),
          ),
        ),
        ListTile(
          title: const Text('Attachments & Notes'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Upload Files'),
          ),
        ),
      ],
    );
  }
}
