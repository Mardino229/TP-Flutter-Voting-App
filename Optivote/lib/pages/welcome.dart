import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcome_Page extends StatelessWidget {
  const Welcome_Page({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight*0.2,
          ),
          Image(
            image: AssetImage('assets/logo/Fichier 1@4x.png'),
            width: screenWidth*0.7,
          ),
          SizedBox(
            height: screenHeight*0.1,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(8, 109, 42, 1),
                      Color.fromRGBO(15, 211, 80, 1)
                    ], // Les couleurs du dégradé
                    begin: Alignment.topCenter, // Point de départ
                    end: Alignment.bottomCenter, // Point de fin
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(67.0), // Arrondi en haut à gauche
                    topRight: Radius.circular(67.0), // Arrondi en haut à droite
                  ),
                ),
                padding: EdgeInsets.only(left: screenWidth*0.075, right:screenWidth*0.075),

                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.07,),
                      Text(
                        'Bienvenue!                   ',
                        style: TextStyle(fontSize: screenWidth*0.1, color: Colors.white),
                      ),
                      SizedBox(height: screenHeight*0.030,),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut',
                        style: TextStyle(fontSize: screenWidth*0.038, color: Colors.white),

                      ),
                      SizedBox(height: screenHeight*0.030,),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  side: BorderSide(color: Color(0xFF707070), width: 1),
                                )),
                                foregroundColor: MaterialStateProperty.all(Colors.black)
                            ),
                            onPressed: () {
                              context.push("/connexion");
                            },
                            child: Text("Se connecter",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.038,
                                  fontWeight: FontWeight.w100
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(14, 128, 52, 0.81)),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  side: BorderSide(color: Color(0xFF707070), width: 1),
                                )),
                                foregroundColor: MaterialStateProperty.all(Colors.white)
                            ),
                            onPressed: () {
                              context.push("/inscription");
                            },
                            child: Text("Créer un compte",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w100
                              ),
                            ),
                          ),

                        ],
                      ),
                      ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
