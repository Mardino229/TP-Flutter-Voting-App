import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardVote extends StatefulWidget {
  const DashboardVote({super.key});

  @override
  State<DashboardVote> createState() => _DashboardVoteState();
}

class _DashboardVoteState extends State<DashboardVote> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> nomElection = ["Election municipale 2025","Election miss UAC 2025","Election responsable 2025","Election miss 2025","Election législative 2025","Election presidentielle 2026"];
    List<String> periode=["22/01/2025-22/02/2025","22/01/2025-22/02/2025","22/01/2025-22/02/2025","22/01/2025-22/02/2025","22/01/2025-22/02/2025","30/03/2026-22/04/2026"];
    int nbreVotes = 123;
    int nbreVotants = 1234;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 246, 244, 1),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.015,
            width: screenWidth*0.2,
          ),

          Center(
            child:Row(
              children: [
                SizedBox(width: screenWidth*0.045,),
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5), // Décalage de l'ombre
                      ),
                    ], // Coins arrondis
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, top: screenHeight * 0.01),
                    child: Text(
                      "Votes",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: ()=>_showAlertDialog(context)
                    , icon:Icon(Icons.logout,color: Colors.red,))
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Center(
            child: Stack(
              clipBehavior: Clip
                  .none, // Permet au CircleAvatar de dépasser les limites du Container
              children: [
                Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.32,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image 1.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.04, top: screenHeight * 0.04),
                      child: Text(
                        "Hello !\nWelcome back here.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Positioned(
                  top: screenHeight * 0.187, // Décalage vers le haut
                  left: screenWidth * 0.3, // Décalage vers la gauche
                  child: CircleAvatar(
                    radius: screenWidth * 0.13,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage('assets/logo/Fichier 1@4x.png'),
                      height: screenHeight * 0.075,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -screenHeight * 0.03,
                  left: screenWidth * 0.025,
                  // Décalage vers la gauche
                  child: Container(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), // Coins arrondis
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5), // Décalage de l'ombre
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/streamline_politics-vote-2-solid.png'),
                          height: 70,
                        ),
                        Text(
                          "$nbreVotes\nVotes",
                          style: TextStyle(fontSize: screenWidth * 0.02),
                        ),
                        SizedBox(
                          width: screenWidth * 0.4,
                        ),
                        Icon(
                          Icons.person_outline_outlined,
                          size: 40,
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        Text(
                          "$nbreVotants\nVotants",
                          style: TextStyle(fontSize: screenWidth * 0.02),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5), // Décalage de l'ombre
                  ),
                ], // Coins arrondis
              ),
              child: Column(children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Text("Votes créés.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w100,
                        )),
                    SizedBox(
                      width: screenWidth * 0.4,
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/see_all_vote');
                      },
                      child: Text(
                        "Voir plus",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.06, top: screenHeight * 0.01),
                   child: Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromRGBO(14, 128, 52, 0.14)),
                            elevation: WidgetStateProperty.all(0),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                                side: BorderSide(
                                    color: Color(0xFF707070), width: 1),
                              ),
                            ),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.black),
                            fixedSize: WidgetStateProperty.all(Size(
                                screenWidth * 0.3,
                                screenHeight * 0.055)), // Taille fixe
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.hourglass_top),
                              Text(
                                "En cours",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: screenWidth * 0.15,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Color.fromRGBO(14, 128, 52, 1)),
                              elevation: WidgetStateProperty.all(0),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                                side: BorderSide(
                                    color: Color(0xFF707070), width: 1),
                              )),
                              fixedSize: WidgetStateProperty.all(Size(
                                  screenWidth * 0.32, screenHeight * 0.055)),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.hourglass_full),
                              Text(
                                "Terminé",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        nomElection.length,
                        (index) => Card(
                          //margin: const EdgeInsets.symmetric(vertical: 8.0),
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          child: GestureDetector(
                            onTap:(){},
                            child:Row(
                              children: [
                                Image(image: AssetImage("assets/img2.png"),height: screenHeight*0.08,),
                                Column(
                                  children: [
                                    Text(nomElection[index],style: TextStyle(fontSize: screenWidth*0.04,fontWeight: FontWeight.bold),),
                                    Text(periode[index],style: TextStyle(fontSize: screenWidth*0.04,)),
                                  ],
                                ),

                              ],
                            )
                          )

                          ),
                        ),
                      ),
                    ),
                  ),
              ],),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: screenWidth * 0.15, top: screenHeight * 0.025),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color.fromRGBO(14, 128, 52, 1)),
                      elevation: WidgetStateProperty.all(0),
                      shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: BorderSide(
                                color: Color(0xFF707070), width: 1),
                          )),
                      foregroundColor:
                      WidgetStateProperty.all(Colors.white)),
                  onPressed:(){
                    context.push('/creation_vote');
                  },
                  child: Row(children: [
                   Icon(Icons.add),
                    Text("Créer une élection",style: TextStyle(color:Colors.white,fontSize: screenWidth*0.06,),),
                  ],),
                ),

                ],
            )
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Expanded(
              child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
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
                    topLeft: Radius.circular(20.0), // Arrondi en haut à gauche
                    topRight: Radius.circular(20.0), // Arrondi en haut à droite
                  ),
                ),
                padding: EdgeInsets.only(
                    left: screenWidth * 0.075, right: screenWidth * 0.075),
              ),
              Positioned(
                top: -screenHeight * 0.02,
                left: screenWidth * 0.42,
                child: Container(
                  width: screenWidth * 0.15,
                  height: screenHeight * 0.065,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5), // Décalage de l'ombre
                      ),
                    ], // Coins arrondis
                  ),
                  child: IconButton(
                    icon: Icon(Icons.home, size: 40, color: Colors.black),
                    onPressed: () {
                      // Action pour retourner à l'accueil
                    },
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Déconnexion"),
          content: Text("Voulez-vous vraiment continuer ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                // Action à effectuer
                context.go('/');

                print("Action confirmée !");
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
