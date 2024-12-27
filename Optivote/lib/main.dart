import 'package:flutter/material.dart';
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ResetPasswordPage1(),
        '/verify_email': (context) => ResetPasswordPage2(),
        '/new_password': (context) => NewPasswordPage(),
      },
    );
  }
}