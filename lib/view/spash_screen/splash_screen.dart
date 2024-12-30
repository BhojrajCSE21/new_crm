import 'package:flutter/material.dart';
import 'package:new_crm/utils/general/secure_storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await _secureStorage.readToken();

    // Simulate a short delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 252, 252, 252), // Background color for the splash screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo/image
            Image.asset(
              'assets/images/logo.png', // Correct path to your asset
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            // Display the app name or title
            const Text(
              "Micronet CRM",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 181, 255),
              ),
            ),
            const SizedBox(height: 20),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 27, 133, 253)),
            ),
          ],
        ),
      ),
    );
  }
}
