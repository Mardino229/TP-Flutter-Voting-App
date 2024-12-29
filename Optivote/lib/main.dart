import 'package:flutter/material.dart';
import 'package:optivote/pages/connexion.dart';
import 'package:optivote/pages/inscription.dart';
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';
import 'package:optivote/pages/welcome.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Welcome_Page(),
    ),
    GoRoute(
      path:'/connexion',
      builder:(context, state) => Login(),
    ),
    GoRoute(
      path:'/inscription',
      builder:(context, state) => Inscription(),
    ),
    GoRoute(
      path:'/reset_password',
      builder:(context, state) => ResetPasswordPage1(),
    ),
    GoRoute(
      path:'/verify_email',
      builder:(context, state) => ResetPasswordPage2(),
    ),
    GoRoute(
      path:'/new_password',
      builder:(context, state) => NewPasswordPage(),
    ),
  ],
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'OptiVote',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3172B8)),
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
    );
  }
}
