import 'package:flutter/material.dart';
import 'package:new_crm/view/dashboard/widgets/calendar_widget.dart';
import 'package:new_crm/view/menu/widgets/main_menu.dart'; // Import the MainMenuDrawer

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Search bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Color.fromARGB(179, 12, 12, 12)),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 14, 13, 13)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 253, 253, 253),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
              ),
            ),
            const SizedBox(width: 10),
            // Profile icon
            GestureDetector(
              onTap: () {
                // Action when profile icon is tapped
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile tapped')),
                );
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: MainMenuDrawer(), // Add the drawer
      body: const CustomCalendarWidget(),
    );
  }
}
