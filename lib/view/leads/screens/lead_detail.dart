import 'package:flutter/material.dart';

class ContactDetailScreen extends StatefulWidget {
  final String leadName;
  final String leadCompany;

  const ContactDetailScreen({
    super.key,
    required this.leadName,
    required this.leadCompany,
  });

  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Main TabController for Activities, Details, Timeline
  late TabController _activitiesTabController; // Nested TabController for Activities sub-tabs
  String currentStatus = 'Open - Not Contacted';
  final List<String> statusOptions = [
    'Open - Not Contacted',
    'Working - Contacted',
    'Closed - Converted',
    'Closed - Not Converted'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _activitiesTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _activitiesTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Lead Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Activities'),
            Tab(text: 'Details'),
            Tab(text: 'Timeline'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Activities Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Activities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TabBar(
                  controller: _activitiesTabController,
                  tabs: const [
                    Tab(text: 'Tasks'),
                    Tab(text: 'Meetings'),
                    Tab(text: 'Calls'),
                    Tab(text: 'Attachments'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    controller: _activitiesTabController,
                    children: [
                      _buildActivityTab('Tasks'),
                      _buildActivityTab('Meetings'),
                      _buildActivityTab('Calls'),
                      _buildActivityTab('Attachments'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Details Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDetailsTab(),
          ),
          // Timeline Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTimelineTab(),
          ),
        ],
      ),
    );
  }

  // Function to build activity tabs content
  Widget _buildActivityTab(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Add $title'),
      ),
    );
  }

  // Details Tab UI
  Widget _buildDetailsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Lead Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildInfoRow('Name:', widget.leadName),
        _buildInfoRow('Company Name:', widget.leadCompany),
        const SizedBox(height: 16),
        const Text('Address Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildInfoRow('Street:', 'NGP'),
        _buildInfoRow('City:', 'NAGPUR'),
        _buildInfoRow('Zip Code:', '445545'),
        _buildInfoRow('State:', 'MH'),
        _buildInfoRow('Country:', 'INDIA'),
      ],
    );
  }

  // Helper function to create row widgets for details
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  // Timeline Tab UI
  Widget _buildTimelineTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Timeline Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildInfoRow('Mode of Communication:', 'wqwqwqwq'),
        _buildInfoRow('Company Name:', 'asdfadfasf'),
      ],
    );
  }
}
