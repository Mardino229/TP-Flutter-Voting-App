import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Group 1000003745.png',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 24),
              Text(
                "Vérifiez votre boîte mail",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "Nous vous avons envoyé des instructions à suivre pour réinitialiser votre mot de passe.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/new_password');
                  },
                  child: Text("Vérifier le mail"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006400),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Vous n'avez pas reçu l'e-mail ? Vérifiez votre dossier spam ou ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  print("Renvoyer l'email");
                },
                child: Text(
                  "renvoyer l'e-mail",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}