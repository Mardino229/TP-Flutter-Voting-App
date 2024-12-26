import 'package:flutter/material.dart';
import 'package:optivote/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OptiVote',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3172B8)),
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
      supportedLocales: [
        Locale('fr'), // French
      ],
      locale: const Locale('fr'),
      home: const Welcome_Page(),
    );
  }
}
