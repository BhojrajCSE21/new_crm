import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'SHIVAM', 'accountName': 'SPACETECH'},
      {'name': 'RAJ', 'accountName': 'ACE'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
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
                contact['name'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                contact['accountName'] ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContactDetailsScreen(contactName: contact['name']),
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

class ContactDetailsScreen extends StatelessWidget {
  final String? contactName;

  const ContactDetailsScreen({Key? key, required this.contactName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(contactName ?? ''),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle actions for Send Email, Edit, and Delete
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'send_email', child: Text('Send Email')),
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
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
                        'Contact Owner: Admin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.blue, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Email: shivam@gmail.com',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.green, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Phone: 5454548887',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.apartment, color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Department: GOLDEN_EYE',
                            style: TextStyle(fontSize: 14),
                          ),
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
                  ActivitiesTab(),
                  DetailsTab(),
                  ConnectionsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivitiesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.task),
          label: const Text('Task'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.meeting_room),
          label: const Text('Meeting'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.call),
          label: const Text('Call'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.attachment),
          label: const Text('Attachment'),
        ),
      ],
    );
  }
}

class DetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Name: SHIVAMPATIL'),
        const Text('Company Name: SPACETECH'),
        const Text('Date of Birth: 2024-12-05T00:00:00Z'),
        const Text('Fax: 1236547889'),
        const Text('Mobile: 5454548887'),
        const Text('Email: shivam@gmail.com'),
        const Text('Website: www.shivam.com'),
        const Text('Title: ENGG.hh'),
        const Text('Department: GOLDEN_EYE'),
        const SizedBox(height: 16),
        const Text('Address Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Mailing Address: FRIENDS COLONY, NGP, MH, INDIA'),
        const Text('Other Address: REVATI NAGAR, NAGPUR, MAHARASHTRA, INDIA'),
        const SizedBox(height: 16),
        const Text('Description Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text('Description: '),
      ],
    );
  }
}

class ConnectionsTab extends StatelessWidget {
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
