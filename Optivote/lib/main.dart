import 'package:flutter/material.dart';
import 'package:optivote/Ajouter_vote/dashboard_vote.dart';
import 'package:optivote/Ajouter_vote/tour2.dart';
import 'package:optivote/Ajouter_vote/voir_tous_les_votes.dart';
import 'package:optivote/pages/addCandidat.dart';
import 'package:optivote/pages/connexion.dart';
import 'package:optivote/pages/inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Ajouter_vote/details_election.dart';
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';
import 'Ajouter_vote/creation_vote.dart';
import 'user/home_user_page.dart';
import 'user/detail_user.dart';
import 'admin/detail_admin.dart';
import 'package:optivote/pages/welcome.dart';
import 'package:go_router/go_router.dart';

GoRouter route(token, role) {
  return GoRouter(
    initialLocation: token==""? '/connexion'
        : role=="user"? '/home_user' : '/dashboard_vote',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Welcome(),
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
      GoRoute(
        path: '/details_user/:id',
        // builder: (context, state) => NewPasswordPage(),
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return DetailUser();
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
        path: '/detail_vote/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return DetailUser();
        },
      ),
      GoRoute(
        path: '/detail_election/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return ElectionDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/add_candidat/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return AddCandidat(id: id);
        },
      ),
      GoRoute(
        path: '/second_tour/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return SecondTourScreen(id: id);
        },
      ),
      GoRoute(
        path: '/detail_vote_admin',
        builder: (context, state) => DetailAdmin(),
      ),
    ],
  );
}
//
// final _router  = GoRouter(
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => Welcome(),
//     ),
//     //liens d'authentification
//     GoRoute(
//       path: '/connexion',
//       builder: (context, state) => Login(),
//     ),
//     GoRoute(
//       path: '/inscription',
//       builder: (context, state) => Inscription(),
//     ),
//     //liens de reset password
//     GoRoute(
//       path: '/reset_password',
//       builder: (context, state) => ResetPasswordPage1(),
//     ),
//     GoRoute(
//       path: '/verify_email',
//       builder: (context, state) => ResetPasswordPage2(),
//     ),
//     GoRoute(
//       path: '/new_password/:email',
//       // builder: (context, state) => NewPasswordPage(),
//       builder: (context, state) {
//         final String email = state.pathParameters['email']!;
//         return NewPasswordPage(email: email);
//       },
//     ),
//     //lien vers la page de création de vote
//     GoRoute(
//       path: '/creation_vote',
//       builder: (context, state) => CreateVotePage(),
//     ),
//     //lien vers la page du dashboard de votes
//     GoRoute(
//       path: '/dashboard_vote',
//       builder: (context, state) => DashboardVote(),
//     ),
//     //lien vers la page pour voir tous les votes
//     GoRoute(
//       path: '/see_all_vote',
//       builder: (context, state) => SeeAllVotes(),
//     ),
//     //liens vers les pages user_pages
//     GoRoute(
//       path: '/home_user',
//       builder: (context, state) => HomeUserPage(),
//     ),
//     GoRoute(
//       path: '/detail_vote',
//       builder: (context, state) => DetailUser(),
//     ),
//     GoRoute(
//       path: '/detail_vote_admin',
//       builder: (context, state) => DetailAdmin(),
//     ),
//   ],
// );
// // void main() {
// //   runApp(MyApp());
// // }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  String? role = sharedPreferences.getString("role");
  runApp(MyApp(authToken: token, role: role));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authToken, required this.role});
  final String? authToken;
  final String? role;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: route(authToken, role),
      debugShowCheckedModeBanner: false,
      title: 'OptiVote',
    );
  }
}
