import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:optivote/data/models/election.dart';
import 'package:optivote/data/services/authentificate_service.dart';
import 'package:optivote/data/services/election_service.dart';
import 'package:optivote/data/services/resultat_service.dart';
import 'package:optivote/data/services/vote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/candidat.dart';
import '../data/models/resultat.dart';


class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final AuthentificateService authentificateService = AuthentificateService();
  final ElectionService electionService = ElectionService();
  final VoteService voteService = VoteService();
  final ResultatService resultatService = ResultatService();
  // Candidate selection variables

  late List<Resultat> resultatElection = [];
  Candidat? _selectedCandidate;
  Election election = Election();
  List<Election> elections = [];
  List<Election> electionsFinished = [];
  bool _hasVoted = false;
  bool loading = false;
  bool loading1 = false;
  bool loading4 = false;
  bool loading2 = false;
  bool loading3 = false;
  int _totalVotes = 0;

  finishedElections() async {
    setState(() {
      loading4 = true;
    });
    try {
      electionsFinished = await electionService.getAllCompleted();
      setState(() {
        loading4 = false;
      });
      // print(elections);
    } on DioException catch (e) {
      if (e.response != null) {
        // print(e.response?.data);
        // print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading4 = false;
      });
    }
  }

  electionInProgress() async {
    setState(() {
      loading1 = true;
      loading3 = true;
    });
    try {
      List<Election> elections = [];
      elections = await electionService.getAllInProgress();
      election = elections[0];
      setState(() {
        loading1 = false;
      });
      hasVoted();
    } on DioException catch (e) {
      if (e.response != null) {
        // print(e.response?.data);
        // print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading1 = false;
      });
    }
  }

  retrieveResultat() async {
    try {
      resultatElection = await resultatService.getAll(election.id.toString());
      _totalVotes = 0;
      for (int i=0; i<resultatElection.length; i++){
        _totalVotes += resultatElection[i].nbr_vote!;
      }
      setState(() {
        loading3 = false;
      });
    } on DioException catch (e) {
      if (e.response != null) {
        // print(e.response?.data);
        // print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading3 = false;
      });
    }
  }

  hasVoted() async {
    try {
      final response = await voteService.verifyVote(election.id.toString());
      setState(() {
        _hasVoted = !response["success"];
      });
      Fluttertoast.showToast(msg: response["message"]);
      retrieveResultat();
    } on DioException catch (e) {
      if (e.response != null) {
        // print(e.response?.data);
        // print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      // setState(() {
      //   loading3 = false;
      // });
    }
  }

  vote(id) async {
    if (_selectedCandidate != null) {
      setState(() {
        loading2 = true;
      });
      try {
        final pref = await SharedPreferences.getInstance();
        int? userId = pref.getInt("id") ;
        Map<String, dynamic> data = {
          "election_id": election.id,
          "candidat_id": id,
          "user_id": userId
        };
        final response = await voteService.vote(data);

        Fluttertoast.showToast(msg: response["message"]);
        retrieveResultat();
        hasVoted();
      } on DioException catch (e) {
        if (e.response != null) {
          // print(e.response?.data);
          // print(e.response?.statusCode);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          // print(e.requestOptions);
          // print(e.message);
        }

        Fluttertoast.showToast(msg: "Une erreur est survenue");
      } finally {
        setState(() {
          loading2 = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vote soumis pour ${_selectedCandidate!.name}'),
          backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner un candidat'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  logout() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await authentificateService.logout();
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
        // print(e.response);
        // print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
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
    electionInProgress();
    finishedElections();
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

  void _submitVote() {
    if (_selectedCandidate != null) {
      setState(() {
        // _selectedCandidate!.votes++;
        _totalVotes++;
        _hasVoted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vote soumis pour ${_selectedCandidate!.name}'),
          backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner un candidat'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop(); // Quitte l'application
      return false; // Empêche l'action de retour
    },
    child:  Scaffold(
      backgroundColor: Color.fromRGBO(243, 246, 244, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: loading1
              ? SizedBox(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  "Optivote",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
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
      body: loading1
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.green,
              ),
            )
          : election.name == null
                ?Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth * 0.9, // Limite la largeur pour un look centré
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Center(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Color.fromRGBO(14, 128, 52, 1),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.how_to_vote,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Aucune élection en cours",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Liste des élections terminées",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(14, 128, 52, 1),
                          ),
                        ),
                      ),
                      !loading4
                          ? electionsFinished.length > 0 ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: electionsFinished.length,
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
                                    "/details_user_election/${electionsFinished[index].id}");
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
                                            "${electionsFinished[index].name}",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenHeight * 0.005),
                                          Text(
                                            "${electionsFinished[index].startDate}-${electionsFinished[index].endDate}",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.grey[800],
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
                          : Center(
                        child: Text("Aucune élection terminée"),
                      )
                      : Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.green.shade600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          : FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Center(
                          child: Stack(clipBehavior: Clip.none, children: [
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
                                  child: loading1
                                      ? SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.green,
                                          ),
                                        )
                                      : election.name != null
                                          ? Text(
                                              "${election.name}\nChoisissez votre candidat dans la période du ${election.startDate} au ${election.endDate}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth * 0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Text(
                                              "Aucune élection en cours",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth * 0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                )),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/streamline_politics-vote-2-solid.png'),
                                      height: 70,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "$_totalVotes\nVotes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.02),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: screenHeight * 0.04),

                        // Candidate Selection Section
                        Center(
                          child: Container(
                            width: screenWidth * 0.9,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: loading3
                                  ? [
                                      SizedBox(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ]
                                  : resultatElection.isNotEmpty
                                      ? [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              "Candidats",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.05,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    14, 128, 52, 1),
                                              ),
                                            ),
                                          ),
                                          ...resultatElection.map((resultat) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          _selectedCandidate ==
                                                                  resultat
                                                                      .candidat
                                                              ? Color.fromRGBO(
                                                                  14,
                                                                  128,
                                                                  52,
                                                                  1)
                                                              : Colors
                                                                  .grey[300]!,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: _selectedCandidate ==
                                                          resultat.candidat
                                                      ? Color.fromRGBO(
                                                          14, 128, 52, 0.1)
                                                      : Colors.white,
                                                ),
                                                child: ListTile(
                                                  onTap: !_hasVoted
                                                      ? () {
                                                          setState(() {
                                                            _selectedCandidate =
                                                                resultat
                                                                    .candidat;
                                                          });
                                                        }
                                                      : null,
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: NetworkImage(
                                                        '${resultat.candidat?.photo}'),
                                                  ),
                                                  title: Text(
                                                    "${resultat.candidat?.name}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  subtitle: _hasVoted
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${resultat.candidat?.description}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),
                                                            LinearProgressIndicator(
                                                              value: (resultat.percentage ?? 0)/100,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      300],
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Color.fromRGBO(
                                                                          14,
                                                                          128,
                                                                          52,
                                                                          1)),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              '${(resultat.percentage ?? 0).toStringAsFixed(2)}%',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        )
                                                      : Text(
                                                          "${resultat.candidat?.description}",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                  trailing: !_hasVoted
                                                      ? Radio<Candidat?>(
                                                          value:
                                                              resultat.candidat,
                                                          groupValue:
                                                              _selectedCandidate,
                                                          activeColor:
                                                              Color.fromRGBO(14,
                                                                  128, 52, 1),
                                                          onChanged: (Candidat?
                                                              value) {
                                                            setState(() {
                                                              _selectedCandidate =
                                                                  value;
                                                            });
                                                          },
                                                        )
                                                      : null,
                                                ),
                                              )),
                                          if (!_hasVoted)
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                    horizontal: 16),
                                                child: ElevatedButton.icon(
                                                  onPressed: () => {
                                                    vote(_selectedCandidate?.id)
                                                  },
                                                  icon: Icon(Icons.how_to_vote,
                                                      color: Colors.white),
                                                  label: !loading2
                                                      ? Text(
                                                          "Valider mon vote",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                screenWidth *
                                                                    0.04,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 3,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              14, 128, 52, 1),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth *
                                                                      0.2,
                                                              vertical: 15),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          32))),
                                                ),
                                              ),
                                            ),
                                        ]
                                      : [
                                        Center(
                                          child: SizedBox(
                                            child: Text("Aucun candidat. Patientez l'ajout des candidats."),
                                          ),
                                        ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                ),
    )
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Voulez-vous vraiment vous déconnecter ?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: !loading? Text(
                "Déconnexion",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ): SizedBox(
                child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                ),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      },
    );
  }
}
