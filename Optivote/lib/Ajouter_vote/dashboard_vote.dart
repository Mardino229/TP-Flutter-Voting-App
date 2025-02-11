import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:optivote/Ajouter_vote/details_election.dart';
import 'package:optivote/data/models/election.dart';
import 'package:optivote/data/services/authentificate_service.dart';
import 'package:optivote/data/services/election_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardVote extends StatefulWidget {
  const DashboardVote({super.key});

  @override
  State<DashboardVote> createState() => _DashboardVoteState();
}

class _DashboardVoteState extends State<DashboardVote>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool loading = false;
  bool loading1 = false;
  bool loading2 = false;
  int? nbr_election;
  final authenticatedService = AuthentificateService();
  final electionService = ElectionService();
  String status = "";
  List<Election> elections = [];

  allElections() async {
    setState(() {
      loading1 = true;
      status = "";
    });
    try {
      elections = await electionService.getAll();
      setState(() {
        loading1 = false;
      });
      print(elections);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading1 = false;
      });
    }
  }
  notStartedElections() async {
    setState(() {
      loading1 = true;
      status = "not_started";
    });
    try {
      elections = await electionService.getAllNotStarted();
      setState(() {
        loading1 = false;
      });
      print(elections);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading1 = false;
      });
    }
  }
  inProgressElections() async {
    setState(() {
      loading1 = true;
      status = "in_progress";
    });
    try {
      elections = await electionService.getAllInProgress();
      setState(() {
        loading1 = false;
      });
      print(elections);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading1 = false;
      });
    }
  }
  finishedElections() async {
    setState(() {
      loading1 = true;
      status = "finished";
    });
    try {
      elections = await electionService.getAllCompleted();
      setState(() {
        loading1 = false;
      });
      print(elections);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading1 = false;
      });
    }
  }
  dashboard() async {
    setState(() {
      loading2 = true;
    });
    try {
      final response = await electionService.dashboard();
      if (response["success"]) {
        nbr_election = response["body"];
        setState(() {
          loading2 = false;
        });
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading2 = false;
      });
    }
  }
  Future<void> logout() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await authenticatedService.logout();
      print(response);
      if (response["success"]) {
        Fluttertoast.showToast(msg: response["message"]);
        final sharedPref = await SharedPreferences.getInstance();

        sharedPref.setString("token", "");
        sharedPref.setInt("id", 0);
        sharedPref.setString("role", "");
        context.push("/");
      } else {
        Fluttertoast.showToast(msg: response["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response);
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

  @override
  void initState() {
    super.initState();
    dashboard();
    allElections();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
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

    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 246, 244, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            "Election",
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Hero(
              tag: 'logoutButton',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _showLogoutDialog(context),
                    icon: Icon(Icons.logout, color: Colors.red),
                    tooltip: 'Déconnexion',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
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
                              left: screenWidth * 0.04,
                              top: screenHeight * 0.04),
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
                      child: Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/streamline_politics-vote-2-solid.png'),
                                height: 70,
                              ),
                              loading2
                                  ? SizedBox(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      "$nbr_election\nElections",
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.02),
                                    ),
                            ],
                          ),
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
                  height: screenHeight * 0.18,
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
                  child: Column(
                    children: [
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
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: status == "in_progress"?
                                    ButtonStyle(
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
                                            screenWidth * 0.32,
                                            screenHeight * 0.055)),
                                        foregroundColor:
                                        WidgetStateProperty.all(Colors.white)):
                                    ButtonStyle(
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
                                    onPressed: () {inProgressElections();},
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
                                  style: status == "finished"?
                                  ButtonStyle(
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
                                          screenWidth * 0.32,
                                          screenHeight * 0.055)),
                                      foregroundColor:
                                      WidgetStateProperty.all(Colors.white)):
                                  ButtonStyle(
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
                                  onPressed: () {finishedElections();},
                                  child: Row(
                                    children: [
                                      Icon(Icons.hourglass_full),
                                      Text(
                                        "Terminé",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10), // Espacement entre les lignes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: status == "not_started"?
                                    ButtonStyle(
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
                                            screenWidth * 0.32,
                                            screenHeight * 0.055)),
                                        foregroundColor:
                                        WidgetStateProperty.all(Colors.white)):
                                    ButtonStyle(
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
                                    onPressed: () {notStartedElections();},
                                    child: Row(
                                      children: [
                                        Icon(Icons.hourglass_empty),
                                        Text(
                                          "A venir",
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
                                  style: status == ""?
                                  ButtonStyle(
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
                                          screenWidth * 0.32,
                                          screenHeight * 0.055)),
                                      foregroundColor:
                                      WidgetStateProperty.all(Colors.white)):
                                  ButtonStyle(
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
                                  onPressed: () {allElections();},
                                  child: Row(
                                    children: [
                                      Icon(Icons.hourglass_disabled),
                                      Text(
                                        "Voir tous",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: !loading1
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: elections.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.01,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push(
                                    "/detail_election/${elections[index].id}");
                              },
                              borderRadius: BorderRadius.circular(15),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.03),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: AssetImage("assets/img2.png"),
                                        height: screenHeight * 0.08,
                                        width: screenWidth * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${elections[index].name}",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenHeight * 0.005),
                                          Text(
                                            "${elections[index].startDate}-${elections[index].endDate}",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.green.shade600,
                        ),
                      ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/creation_vote');
        },
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 4,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Créer une élection",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: !loading, // Empêche la fermeture en dehors si en chargement
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.logout, color: Colors.red),
              const SizedBox(width: 10),
              const  Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: loading
              ? const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(), // Affiche le loader
            ),
          )
              : const Text(
            "Voulez-vous vraiment vous déconnecter ?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: loading
                  ? null // Désactive si en chargement
                  : () => Navigator.of(context).pop(),
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: loading
                  ? null // Désactive si en chargement
                  : () async {
                await logout(); // Appelle la déconnexion
                if (!loading) Navigator.of(context).pop(); // Ferme le dialogue
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: loading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Déconnexion",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      },
    );
  }

}
