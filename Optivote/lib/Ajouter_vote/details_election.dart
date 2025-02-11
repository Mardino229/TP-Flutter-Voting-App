import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:optivote/data/models/candidat.dart';
import 'package:optivote/data/models/electionDetail.dart';
import 'package:optivote/data/models/resultat.dart';
import 'package:optivote/data/services/candidat_service.dart';
import 'package:optivote/data/services/resultat_service.dart';

import '../data/models/election.dart';
import '../data/services/election_service.dart';

class ElectionDetailsScreen extends StatefulWidget {
  final String id;

  const ElectionDetailsScreen({super.key, required this.id});

  @override
  State<ElectionDetailsScreen> createState() => _ElectionDetailsScreenState();
}

class _ElectionDetailsScreenState extends State<ElectionDetailsScreen> {

  late Election election = new Election();
  late ElectionDetails electionDetails = new ElectionDetails();
  late List<Resultat> resultatElection = [];
  bool loading = false;
  bool loading2 = false;
  bool loading3 = false;
  bool loading4 = false;
  bool _isVotingClosed = false;
  List<Candidat> candidats = [];
  final candidatService = CandidatService();
  final resultatService = ResultatService();
  final electionService = ElectionService();

  retrieveElection() async {
    setState(() {
      loading = true;
    });
    try {
      election = await electionService.get(widget.id);
      setState(() {
        loading = false;
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
  retrieveDetailsElection() async {
    setState(() {
      loading3 = true;
    });
    try {
      electionDetails = await electionService.getDetails(widget.id);
      setState(() {
        loading3 = false;
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
  retrieveResultat() async {
    setState(() {
      loading2 = true;
    });
    try {
      resultatElection = await resultatService.getAll(widget.id);
      setState(() {
        loading2 = false;
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
        loading4 = false;
      });
      if (response["success"]) {
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
      } else {
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
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/image 1.png",
                      ),
                      opacity: 0.89,
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => context.pop(),
                          ),
                          Text(
                            "${election.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
              child: SingleChildScrollView(
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
                      electionDetails.lead!.length > 0 ||
                              electionDetails.lead!.length == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildGridItem(
                                  title: '${electionDetails.lead?[0]}',
                                  showTrophy: true,
                                ),
                                if(electionDetails.lead!.length > 1) 
                                _buildGridItem(
                                  title: '${electionDetails.lead?[1]}',
                                  showTrophy2: true,
                                ),
                              ],
                            )
                          : Center(
                              child: Text("Aucune option en tête"),
                            ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: ElevatedButton.icon(
                              onPressed: _isVotingClosed
                                  ? null
                                  : () => _showDeleteDialog(context),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                              label: Text(_isVotingClosed
                                  ? 'Vote clôturé'
                                  : "Supprimer l'élection"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.redAccent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push("/second_tour/${widget.id}");
                              },
                              icon: const Icon(
                                Icons.how_to_vote,
                                color: Color.fromRGBO(14, 128, 52, 1),
                              ),
                              label: Text(
                                'Deuxième tour',
                                style: TextStyle(
                                  color: Color.fromRGBO(14, 128, 52, 1),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (loading2)
                        Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.green.shade600,
                          ),
                        ),
                      if (!loading2 && resultatElection.isEmpty)
                        Center(
                          child: Text("Aucun candidat ajouté à cette élection"),
                        ),
                      if (!loading2 && resultatElection.isNotEmpty)
                        ...resultatElection
                            .map((resultat) => _buildResultCard(resultat))
                            .toList(),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
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
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              Icon(Icons.delete, color: Colors.red),
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
              onPressed: () => {Navigator.of(context).pop()},
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
              child: !loading
                  ? Text(
                      "Supprimer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : SizedBox(
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
            ? Color.fromRGBO(14, 128, 52, 1)
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bandeau supérieur
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(8, 109, 42, 1), // Couleur verte
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),

          // Contenu principal de la carte
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centre horizontalement
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image circulaire
                    // CircleAvatar(
                    //   radius: 30, // Taille de l'avatar
                    //   backgroundColor: Colors.grey.shade300,
                    //   backgroundImage: NetworkImage(
                    //     "${resultat.candidat?.photo ?? ''}", // Remplace par ton URL
                    //   ),
                    // ),
                    Container(
                      width: 100, // Définissez la taille souhaitée
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1), // Couleur de l'ombre
                            spreadRadius: 4,                      // Étendue de l'ombre
                            blurRadius: 10,                        // Flou de l'ombre
                            offset: Offset(0, 6),                 // Position de l'ombre (x,y)
                          ),
                        ],
                      ),
                      child: Image.network(
                        resultat.candidat?.photo ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 18),
                    // Nom et description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${resultat.candidat?.name ?? 'Nom indisponible'}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${resultat.candidat?.description ?? 'Description indisponible'}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Votes et pourcentage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${resultat.nbr_vote ?? 0} voies/${electionDetails.nbrVote ?? 0}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      electionDetails.nbrVote == 0
                          ? '0%'
                          : '${(resultat.nbr_vote! / electionDetails.nbrVote! * 100).toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Barre de progression
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (resultat.percentage ?? 0)/100,
                    backgroundColor: Colors.green.shade100,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.green.shade500),
                    minHeight: 8, // Hauteur de la barre
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
