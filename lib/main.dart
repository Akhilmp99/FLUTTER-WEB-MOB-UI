import 'package:flutter/material.dart';
import 'package:webtemplate/Pages/Login.dart';

import 'Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Web App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.lightBlue.shade400,
          secondary: Colors.lightBlue.shade200,
          background: Colors.white,
          surface: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue.shade400,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}