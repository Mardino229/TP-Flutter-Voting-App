import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/authentificated_user.dart';
import '../data/services/authentificate_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool loading = false;
  final userService = AuthentificateService();

  String? _emailError;
  String? _passwordError;

  loginUser() async {
    if (_validateForm()) {
      setState(() {
        loading = true;
      });
      try {
        Map<String, dynamic> data = {
          'email': _emailController.text,
          'password': _passwordController.text
        };
        final response = await userService.login(data);

        if (response["success"]) {
          AuthenticatedUser authUser =
              AuthenticatedUser.fromJson(response["body"]);

          Fluttertoast.showToast(msg: "Utilisateur connecté avec succès");
          // Initialiser une instance de shared preference
          final sharedPref = await SharedPreferences.getInstance();

          // Sauvegerder le token en mémoire
          sharedPref.setString("token", authUser.accessToken!);
          sharedPref.setInt("npi", authUser.npi!);
          sharedPref.setString("role", authUser.role!);
          sharedPref.setInt("id", authUser.id!);
          _emailController.text = "";
          _passwordController.text = "";
          if (authUser.role == "user") {
            context.push("/home_user");
          } else {
            context.push("/dashboard_vote");
          }
        } else {
          setState(() {
            _passwordError = response["message"];
          });
        }
        // dispose();
      } on DioException catch (e) {
        if (e.response != null) {
          print(e.response?.data["errors"]);
          final errors = e.response?.data['errors'];
          errors.forEach((key, value) {
            print('$key: $value'); // Affiche chaque erreur
          });
          //
          // print(formattedErrors);
          // Map<String, String> errors = e.response?.data["errors"];
          setState(() {
            _emailError =
                errors["email"] == null ? "" : errors["email"][0].toString();
            _passwordError = errors["password"] == null
                ? ""
                : errors["password"][0].toString();
          });
          print(e.response?.statusCode);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.requestOptions);
          print(e.message);
        }

        Fluttertoast.showToast(msg: "Une erreur est survenue");
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty;
  }

  bool _validateForm() {
    setState(() {
      // Validation email
      _emailError = !_validateEmail(_emailController.text)
          ? "Veuillez entrer une adresse email valide"
          : null;

      // Validation mot de passe
      _passwordError = !_validatePassword(_passwordController.text)
          ? "Ce champ est obligatoire"
          : null;

      // if (_emailError == null && _npiError == null && _passwordError == null) {
      //   context.push('/home_user');
      // }
    });
    return _validateEmail(_emailController.text) &&
        _validatePassword(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox.expand(
        // Assure que le Stack couvre toute la page
        child: Stack(
          children: [
            // Première partie (1/4 de la hauteur)
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: 0.25,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(8, 109, 42, 1.0),
                    image: DecorationImage(
                      image: AssetImage("assets/image 1.png"),
                      opacity: 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Deuxième partie (1/2 de la hauteur)
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(11, 160, 61, 1.0),
                    image: DecorationImage(
                      image: AssetImage("assets/image 1.png"),
                      opacity: 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Troisième partie (1/4 de la hauteur)
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.25,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 211, 80, 1.0),
                    image: DecorationImage(
                      image: AssetImage("assets/image 1.png"),
                      opacity: 0.45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Stack(
                clipBehavior: Clip
                    .none, // Permet au CircleAvatar de dépasser les limites du Container
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), // Coins arrondis
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Text(
                              "Connexion",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w100),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "E-mail",
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        color: Color.fromRGBO(8, 109, 42, 1)),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: screenHeight * 0.006),
                                  Stack(
                                    children: [
                                      Icon(
                                        Icons
                                            .mail_outline, // L'icône au-dessus du champ
                                        size: 20,
                                        color: Color.fromRGBO(8, 109, 42, 1),
                                      ),
                                      // Le trait de fond
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 1, // Épaisseur du trait
                                          color: Color.fromRGBO(8, 109, 42, 1),
                                        ),
                                      ),
                                      // Le champ de texte
                                      TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 22, bottom: 10),
                                          errorText: _emailError,
                                        ),
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 12,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mot de passe",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(8, 109, 42, 1)),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: screenHeight * 0.006),
                                  Stack(
                                    children: [
                                      Icon(
                                        Icons
                                            .password, // L'icône au-dessus du champ
                                        size: 20,
                                        color: Color.fromRGBO(8, 109, 42, 1),
                                      ),
                                      // Le trait de fond
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 1, // Épaisseur du trait
                                          color: Color.fromRGBO(8, 109, 42, 1),
                                        ),
                                      ),
                                      // Le champ de texte
                                      TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 22, bottom: 10),
                                          errorText: _passwordError,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color:
                                                  Color.fromRGBO(8, 109, 42, 1),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isPasswordVisible =
                                                    !_isPasswordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035),
                                        obscureText: !_isPasswordVisible,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  context.push('/reset_password');
                                },
                                child: Text(
                                  "Mot de passe oublié?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(8, 109, 42, 1),
                                      fontSize: 17),
                                )),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Color.fromRGBO(8, 109, 42, 1)),
                                  elevation: WidgetStateProperty.all(0),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Color(0xFF707070), width: 1),
                                  )),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white)),
                              onPressed: loginUser,
                              child: !loading
                                  ? Text(
                                      "Se connecter",
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w300),
                                    )
                                  : SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.026,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Vous n'avez pas de compte?",
                                    style: TextStyle(
                                      color: Color.fromRGBO(8, 109, 42, 1),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push('/inscription');
                                  },
                                  child: Text(
                                    "S'inscrire",
                                    style: TextStyle(
                                      color: Color.fromRGBO(8, 109, 42, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -80, // Décalage vers le haut
                    right: -20, // Décalage vers la gauche
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage('assets/logo/Fichier 1@4x.png'),
                        height: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
