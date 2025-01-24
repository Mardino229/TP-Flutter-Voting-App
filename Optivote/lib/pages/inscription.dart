import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Insc(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Insc extends StatelessWidget {
  const Insc({super.key});

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
            // Contenu de la page (superposé)
            Center(
              child: Stack(
                clipBehavior: Clip.none, // Permet au CircleAvatar de dépasser les limites du Container
                children: [
                  Container(
                    width: screenWidth*0.85,
                    height: screenHeight*0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), // Coins arrondis
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight*0.03,),
                        Text("Inscription",style: TextStyle(fontSize: screenWidth * 0.09,fontWeight: FontWeight.w100),),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10,),
                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nom complet",style: TextStyle(fontSize: screenWidth * 0.045,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
                              SizedBox(height: screenHeight*0.006),
                              Stack(

                                children: [

                                  Icon(
                                    Icons.person_outline_outlined, // L'icône au-dessus du champ
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
                                      contentPadding: EdgeInsets.only(left: 22,bottom: 10),
                                    ),
                                    style: TextStyle(fontSize: screenWidth * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10,),
                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("E-mail",style: TextStyle(fontSize: screenWidth * 0.045,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
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
                                      contentPadding: EdgeInsets.only(left: 22,bottom: 10),
                                    ),
                                    style: TextStyle(fontSize: screenWidth * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10,),
                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NPI",style: TextStyle(fontSize: screenWidth * 0.045,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
                              SizedBox(height: screenHeight*0.006),
                              Stack(

                                children: [

                                  Icon(
                                    Icons.onetwothree, // L'icône au-dessus du champ
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
                                      contentPadding: EdgeInsets.only(left: 22,bottom: 10),
                                    ),
                                    style: TextStyle(fontSize: screenWidth * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16,),
                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Piece d'identité",style: TextStyle(fontSize: screenWidth * 0.045,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
                              SizedBox(height: screenHeight*0.006),
                              Stack(

                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.badge_outlined, // L'icône au-dessus du champ
                                      size: 20,
                                      color: Color.fromRGBO(8, 109, 42, 1),
                                    ),
                                    SizedBox(width: screenWidth*0.56,),
                                    IconButton(onPressed:(){},
                                      icon:Icon(
                                          Icons.drive_folder_upload_outlined,
                                        size:20,
                                        color: Color.fromRGBO(8, 109, 42, 1),
                                      ),
                                    ),
                                  ],),

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
                                      contentPadding: EdgeInsets.only(left: 22,bottom: 10),
                                    ),
                                    style: TextStyle(fontSize: screenWidth * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mot de passe",style: TextStyle(fontSize: screenWidth * 0.045,color: Color.fromRGBO(8, 109, 42, 1)),textAlign: TextAlign.left,),
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
                                      contentPadding: EdgeInsets.only(left: 22,bottom: 10),
                                    ),
                                    style: TextStyle(fontSize: screenWidth * 0.035),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),



                        SizedBox(height: screenHeight*0.02,),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Color.fromRGBO(8, 109, 42, 1)),
                              elevation: WidgetStateProperty.all(0),
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFF707070), width: 1),
                              )),
                              foregroundColor: WidgetStateProperty.all(Colors.white)
                          ),
                          onPressed: () {
                            context.push('/home_user');
                          },
                          child: Text("S'inscrire",
                            style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.02,),
                        Text("OU",style:TextStyle(color:Color.fromRGBO(8, 109, 42, 1),),),
                        SizedBox(height: screenHeight*0.01,),
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
                        SizedBox(height: screenHeight*0.015,),
                        Row(children: [
                          SizedBox(width: screenWidth*0.1,),
                          Text("Vous avez déja un compte?",style: TextStyle(color:Color.fromRGBO(8, 109, 42, 1),fontSize: screenWidth * 0.035,),),
                          TextButton(
                              onPressed: () {
                                context.push("/connexion");
                              },
                              child: Text("Se connecter",
                                style: TextStyle(
                                  color: Color.fromRGBO(8, 109, 42, 1),
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ],)
                      ],
                    ),
                  ),
                  Positioned(
                    top: -60, // Décalage vers le haut
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