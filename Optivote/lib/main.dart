import 'package:flutter/material.dart';
import 'package:optivote/pages/connexion.dart';
import 'package:optivote/pages/inscription.dart';
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';
import 'Ajouter_vote/creation_vote.dart';
import 'package:optivote/pages/welcome.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Welcome(),
    ),
    GoRoute(
      path: '/connexion',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/inscription',
      builder: (context, state) => Inscription(),
    ),
    GoRoute(
      path: '/reset_password',
      builder: (context, state) => ResetPasswordPage1(),
    ),
    GoRoute(
      path: '/verify_email',
      builder: (context, state) => ResetPasswordPage2(),
    ),
    GoRoute(
      path: '/new_password',
      builder: (context, state) => NewPasswordPage(),
    ),
    GoRoute(
      path: '/creation_vote',
      builder: (context, state) => CreateVotePage(),
    ),
  ],
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'OptiVote',
    );
  }
}
