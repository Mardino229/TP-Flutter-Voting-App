import 'package:flutter/material.dart';
import 'package:optivote/Ajouter_vote/dashboard_vote.dart';
import 'package:optivote/Ajouter_vote/voir_tous_les_votes.dart';
import 'package:optivote/pages/connexion.dart';
import 'package:optivote/pages/inscription.dart';
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';
import 'Ajouter_vote/creation_vote.dart';
import 'user/home_user_page.dart';
import 'user/detail_user.dart';
import 'admin/detail_admin.dart';
import 'package:optivote/pages/welcome.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Welcome(),
    ),
    //liens d'authentification
    GoRoute(
      path: '/connexion',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/inscription',
      builder: (context, state) => Inscription(),
    ),
    //liens de reset password
    GoRoute(
      path: '/reset_password',
      builder: (context, state) => ResetPasswordPage1(),
    ),
    GoRoute(
      path: '/verify_email',
      builder: (context, state) => ResetPasswordPage2(),
    ),
    GoRoute(
      path: '/new_password/:email',
      // builder: (context, state) => NewPasswordPage(),
      builder: (context, state) {
        final String email = state.pathParameters['email']!;
        return NewPasswordPage(email: email);
      },
    ),
    //lien vers la page de création de vote
    GoRoute(
      path: '/creation_vote',
      builder: (context, state) => CreateVotePage(),
    ),
    //lien vers la page du dashboard de votes
    GoRoute(
      path: '/dashboard_vote',
      builder: (context, state) => DashboardVote(),
    ),
    //lien vers la page pour voir tous les votes
    GoRoute(
      path: '/see_all_vote',
      builder: (context, state) => SeeAllVotes(),
    ),
    //liens vers les pages user_pages
    GoRoute(
      path: '/home_user',
      builder: (context, state) => HomeUserPage(),
    ),
    GoRoute(
      path: '/detail_user',
      builder: (context, state) => DetailUser(),
    ),
    GoRoute(
      path: '/detail_vote_admin',
      builder: (context, state) => DetailAdmin(),
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
