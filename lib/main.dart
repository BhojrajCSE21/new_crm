import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:new_crm/view/auth/login_screen.dart';
import 'package:new_crm/view/dashboard/screens/home_view.dart';
import 'package:new_crm/view/spash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_crm/view_models/login_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CRM App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: {
            '/login': (context) => LoginScreen(),
            '/home': (context) => HomePage(),
          },
        ),
      ),
    );
  }
}
