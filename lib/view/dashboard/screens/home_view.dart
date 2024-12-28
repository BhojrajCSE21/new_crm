import 'package:flutter/material.dart';
import 'package:new_crm/view/menu/widgets/main_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40, // Reduced height for the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10), // Center text vertically
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10), // Space between search bar and profile icon
            Container(
              height: 40,
              width: 40, // Smaller size for the profile icon circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // White circle for the profile icon
              ),
              child: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  // Handle profile icon tap
                },
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: MainMenuDrawer(), // Use the MainMenuDrawer from main_menu.dart
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardTile(
              context,
              icon: Icons.dashboard,
              label: 'Dashboard',
              color: Colors.orange,
            ),
            _buildDashboardTile(
              context,
              icon: Icons.leaderboard,
              label: 'Leads',
              color: Colors.green,
            ),
            _buildDashboardTile(
              context,
              icon: Icons.contacts,
              label: 'Contacts',
              color: Colors.blue,
            ),
            _buildDashboardTile(
              context,
              icon: Icons.account_circle,
              label: 'Accounts',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(BuildContext context,
      {required IconData icon, required String label, required Color color}) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label tapped')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
