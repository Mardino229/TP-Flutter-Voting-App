import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'Reset_password_pages/reset_password_page1.dart';
import 'Reset_password_pages/reset_password_page2.dart';
import 'Reset_password_pages/new_password_page.dart';
=======
import 'package:optivote/pages/welcome.dart';
>>>>>>> f71d57653a06bf949bee3c446e5456fa2f89832e

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
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
=======
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
>>>>>>> f71d57653a06bf949bee3c446e5456fa2f89832e
