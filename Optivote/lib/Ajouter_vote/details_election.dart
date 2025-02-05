import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:optivote/Ajouter_vote/tour2.dart';
import 'package:optivote/data/models/candidat.dart';
import 'package:optivote/data/models/electionDetail.dart';
import 'package:optivote/data/models/resultat.dart';
import 'package:optivote/data/services/candidat_service.dart';
import 'package:optivote/data/services/resultat_service.dart';
import 'package:optivote/pages/addCandidat.dart';

import '../data/models/election.dart';
import '../data/services/election_service.dart';

class ElectionDetailsScreen extends StatefulWidget {
  final String id;

  const ElectionDetailsScreen({super.key, required this.id});

  @override
  State<ElectionDetailsScreen> createState() => _ElectionDetailsScreenState();
}

class _ElectionDetailsScreenState extends State<ElectionDetailsScreen> {
  // État pour le timer
  String _timerValue = '12:00:00';
  // État pour le nombre de votants
  int _votersCount = 126;
  // État pour les résultats
  late Election election = new Election();
  late ElectionDetails electionDetails = new ElectionDetails();
  late List<Resultat> resultatElection = [];
  bool loading = false;
  bool loading2 = false;
  bool loading3 = false;
  bool loading4 = false;
  List<Candidat> candidats = [];
  final candidatService = CandidatService();
  final resultatService = ResultatService();
  final electionService = ElectionService();

  final List<VoteOption> _voteOptions = [
    VoteOption(
      title: 'Option 1',
      details:
          'details details details details details details details details',
      votes: 82,
      totalVotes: 100,
    ),
    VoteOption(
      title: 'Option 2',
      details:
          'details details details details details details details details',
      votes: 65,
      totalVotes: 100,
    ),
    VoteOption(
      title: 'Option 3',
      details:
          'details details details details details details details details',
      votes: 45,
      totalVotes: 100,
    ),
  ];

  retrieveElection () async {
    setState(() {
      loading = true;
    });
    try {
      election = await electionService.get(widget.id);
      setState(() {
        loading=false;
      });
      retrieveDetailsElection();
      retrieveResultat();
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
        loading = false;
      });
    }
  }
  retrieveDetailsElection () async {
    setState(() {
      loading3 = true;
    });
    try {
      electionDetails = await electionService.getDetails(widget.id);
      setState(() {
        loading3=false;
      });
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
        loading3 = false;
      });
    }
  }
  retrieveResultat () async {
    setState(() {
      loading2 = true;
    });
    try {
      resultatElection = await resultatService.getAll(widget.id);
      setState(() {
        loading2=false;
      });
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
  deleteElection() async {
    setState(() {
      loading4 = true;
    });
    try {
      final response = await electionService.delete(widget.id);
      setState(() {
        loading4=false;
      });
      if (response["success"]){
        context.push("/dashboard_vote");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${response["message"]}',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            backgroundColor: Color.fromRGBO(14, 128, 52, 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${response["message"]}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
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
        loading = false;
      });
    }
  }

  bool _isVotingClosed = false;

  void _closeVoting() {
    setState(() {
      _isVotingClosed = true;
    });
    // Ajouter ici la logique pour clôturer le vote
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveElection();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if (loading)
            Expanded(
              child: Container(
                 // Fond semi-transparent
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
            ),
          if (!loading)
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green.shade700, Colors.green.shade600],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "${election.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     Text(
                      '${election.startDate} au ${election.endDate}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Vote unique',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (!loading3 && !loading)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGridItem(
                        icon: Icons.timer,
                        title: "${electionDetails.delay}",
                        isActive: !_isVotingClosed,
                      ),
                      _buildGridItem(
                        icon: Icons.people,
                        title: '${electionDetails.nbrVote} votants',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  electionDetails.lead!.length > 0 || electionDetails.lead!.length ==1  ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        _buildGridItem(
                          title: '${electionDetails.lead?[0]}',
                          showTrophy: true,
                        ),

                      _buildGridItem(
                        title: '${electionDetails.lead?[1]}',
                        showTrophy2: true,
                      ),
                    ],
                  ):
                  Center(
                    child: Text("Aucune option en tête"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isVotingClosed ? null : ()=>_showDeleteDialog(context),
                      icon: const Icon(
                          Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(_isVotingClosed
                          ? 'Vote clôturé'
                          : "Supprimer l'élection"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push("/second_tour/${widget.id}");
                      },
                      label: Text(
                        'Deuxième tour',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (loading2)
                    Expanded(
                      child: Container(
                        // Fond semi-transparent
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ),
                    ),
                  if (!loading2 && resultatElection.length==0)
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text("Aucun candidat ajouté à cette élection"),
                        ),
                      )
                    ),
                  if (!loading2 && resultatElection.length>0)
                    Expanded(
                      child: ListView.builder(
                        itemCount: resultatElection.length,
                        itemBuilder: (context, index) =>
                            _buildResultCard(resultatElection[index]),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (loading3)
            Expanded(
              child: Container(
                // Fond semi-transparent
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/add_candidat/${widget.id}");
        },
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 4,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Ajouter les candidats",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

  }

  void _showDeleteDialog(BuildContext context) {
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
                "Supression",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Voulez-vous vraiment supprimer cette élection ?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop()
              },
              child: Text(
                "Annuler",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: deleteElection,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:!loading?
              Text(
                "Supprimer",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ):  SizedBox(
                height: 20,
                width: 20,
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

  Widget _buildGridItem({
    IconData? icon,
    required String title,
    bool isActive = false,
    bool showTrophy = false,
    bool showTrophy2 = false,
  }) {
    // Détermine si c'est le timer et si le vote est clôturé
    final isTimer = icon == Icons.timer;
    final Color backgroundColor = isTimer && _isVotingClosed
        ? Colors.red.shade900
        : isActive
            ? Colors.green.shade600
            : Colors.white;

    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (showTrophy)
            Image.asset(
              'assets/image-removebg-preview 1.png',
            ),
          if (showTrophy2)
            Image.asset(
              'assets/Frame 1000003618.png',
              height: 100,
            )
          else
            Icon(
              icon,
              size: 40,
              color: backgroundColor != Colors.white
                  ? Colors.white
                  : Colors.black54,
            ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: backgroundColor != Colors.white
                  ? Colors.white
                  : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(Resultat resultat) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Image.network(
                    "${resultat.candidat?.photo}", // Remplace par ton URL
                    width: 200, // Optionnel
                    height: 200, // Optionnel
                    fit: BoxFit.cover, // Ajuste l'image
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "${resultat.candidat?.name}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              "${resultat.candidat?.description}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${resultat.nbr_vote} votes/${electionDetails.nbrVote}'),
                Text(
                  electionDetails.nbrVote==0?
                  '0/0':
                  '${(resultat.nbr_vote! / electionDetails.nbrVote! * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: resultat.percentage ?? 0,
              backgroundColor: Colors.green.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

class VoteOption {
  final String title;
  final String details;
  final int votes;
  final int totalVotes;

  const VoteOption({
    required this.title,
    required this.details,
    required this.votes,
    required this.totalVotes,
  });

  double get percentage => votes / totalVotes * 100;
}
