import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../data/services/authentificate_service.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;

  NewPasswordPage({required this.email});
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmPassword = true;

  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool loading = false;
  final userService = AuthentificateService();
  final _formKey = GlobalKey<FormState>();
  String? _codeError;

  resetPassword() async {
      setState(() {
        loading = true;
      });
      try {

        Map<String, dynamic> data = {
          'email': widget.email,
          'otp': _codeController.text,
          'password': _newPasswordController.text,
          'password_confirmation': _confirmPasswordController.text
        };
        final response = await userService.resetPassword(data);

        if (response["success"]){
          Fluttertoast.showToast(msg: "Mot de passe modifié avec succès");

          _showMyDialog(response["message"]);
        } else{
          setState(() {
            _codeError = response["message"];
          });
        }

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

          // setState(() {
          //   _codeError = errors["npi"]==null?"":errors["npi"][0].toString();
          //   _emailError =errors["email"]==null?"": errors["email"][0].toString();
          //   _passwordError = errors["password"]==null?"":errors["password"][0].toString();
          // });

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

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retour à la page de connexion'),
              onPressed: () {
                Navigator.of(context).pop();
                context.push("/connexion");
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une majuscule';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une minuscule';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins un caractère spécial';
    }
    return null;
  }

  String? _validateOTP(String? value) {

    if (value!.length < 6){
      return 'Ce champ doit contenir au moins 6 caractères';
    }
    if (int.tryParse(value) == null){
      return 'Ce champ doit contenir uniquement des chiffres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (value != _newPasswordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Créer un nouveau mot de passe",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Votre nouveau mot de passe doit être différent des anciens, contenir au moins une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Code OTP",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _codeController,
                  validator: _validateOTP,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.qr_code_2_outlined,
                        color: Colors.grey,
                      ), onPressed: () {  },
                    ),
                    errorMaxLines: 3,
                    errorText: _codeError,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                SizedBox(height: 16),
                Text(
                  "Nouveau mot de passe",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureTextNewPassword,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextNewPassword = !_obscureTextNewPassword;
                        });
                      },
                    ),
                    errorMaxLines: 3,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Confirmer le mot de passe",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureTextConfirmPassword,
                  validator: _validateConfirmPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextConfirmPassword =
                              !_obscureTextConfirmPassword;
                        });
                      },
                    ),
                    errorMaxLines: 2,
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        resetPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF006400),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child:!loading?
                    Text("Changer le mot de passe"):
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
