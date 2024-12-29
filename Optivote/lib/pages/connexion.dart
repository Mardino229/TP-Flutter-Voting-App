import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Reset_password_pages/reset_password_page1.dart';
import 'inscription.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackgroundPage(),
      debugShowCheckedModeBanner: false,
      routes:{
        '/inscription':(context) => Inscription(),
        '/reset_password': (context) => ResetPasswordPage1(),
      },
    );
  }
}

class BackgroundPage extends StatelessWidget {
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
                        opacity: 0.35,
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
                        opacity: 0.35,
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                ),
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none, // Permet au CircleAvatar de dépasser les limites du Container
                  children: [
                    Container(
                      width: screenWidth*0.8,
                      height: screenHeight*0.62,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16), // Coins arrondis
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight*0.04,),
                          Text("Connexion",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w100),),
                          SizedBox(height: screenHeight*0.04,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 12.0,),
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("E-mail",style: TextStyle(fontSize: 17,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
                                SizedBox(height: screenHeight*0.006),
                                Stack(

                                  children: [

                                    Icon(
                                      Icons.mail_outline, // L'icône au-dessus du champ
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none, // Supprime les bordures standards
                                        isDense: true, // Réduit l'espace vertical
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 12,),
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mot de passe",style: TextStyle(fontSize: 17,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
                                SizedBox(height: screenHeight*0.006),
                                Stack(

                                  children: [

                                    Icon(
                                      Icons.password, // L'icône au-dessus du champ
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none, // Supprime les bordures standards
                                        isDense: true, // Réduit l'espace vertical
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                print("Boutton pressé");
                                Navigator.of(context).pushNamed('/reset_password');
                              },
                              child: Text("Mot de passe oublié?",
                                style: TextStyle(
                                    color: Color.fromRGBO(8, 109, 42, 1),
                                    fontSize: 17
                                ),
                              )
                          ),
                          SizedBox(height: screenHeight*0.015,),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(8, 109, 42, 1)),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF707070), width: 1),
                                )),
                                foregroundColor: MaterialStateProperty.all(Colors.white)
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            child: Text("Se connecter",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight*0.026,),
                          Text("OU",style:TextStyle(color:Color.fromRGBO(8, 109, 42, 1),),),
                          SizedBox(height: screenHeight*0.026,),
                          Container(
                            width: screenWidth*0.65,
                            height: screenHeight*0.045,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5), // Décalage de l'ombre
                                ),
                              ],// Coins arrondis
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: screenWidth*0.08,height: screenHeight*0.015,),
                                Image(image: AssetImage("assets/img.png"),height: screenHeight*0.015,),
                                TextButton(
                                    onPressed: () {

                                    },
                                    child: Text("Continuer avec Google?",
                                      style: TextStyle(
                                          color: Color.fromRGBO(8, 109, 42, 1),
                                          fontSize: 15
                                      ),
                                    )
                                ),
                              ],
                            ),

                          ),
                          SizedBox(height: screenHeight*0.026,),
                          Row(children: [
                            SizedBox(width: screenWidth*0.1,),
                            Text("Vous n'avez pas de compte?",style: TextStyle(color:Color.fromRGBO(8, 109, 42, 1),),),
                            TextButton(
                                onPressed: ()
                                {
                                  Navigator.of(context).pushNamed('/inscription');
                                },
                                child: Text("S'inscrire",
                                  style: TextStyle(
                                      color: Color.fromRGBO(8, 109, 42, 1),
                                      fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                          ],)
                        ],
                      ),
                    ),
                    Positioned(
                      top: -80, // Décalage vers le haut
                      right: -20, // Décalage vers la gauche
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child:Image(image: AssetImage('assets/logo/Fichier 1@4x.png'),height: 80,) ,
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
