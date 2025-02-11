import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Navigation automatique après 3 secondes
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.go('/connexion'); // ou la route de votre choix
//         Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const AddCandidat()),
// );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Image(
              image: const AssetImage('assets/logo/Fichier 1@4x.png'),
              width: screenWidth * 0.7,
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(8, 109, 42, 1),
            ),
          ),
        ],
      ),
    );
  }
}
