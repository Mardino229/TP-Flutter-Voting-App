import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:optivote/data/models/election.dart';
import 'package:optivote/data/services/election_service.dart';

class CreateVotePage extends StatefulWidget {
  @override
  _CreateVotePageState createState() => _CreateVotePageState();
}

class _CreateVotePageState extends State<CreateVotePage> {
  DateTime? _startDate; // Date de début
  DateTime? _endDate; // Date de fin
  bool loading = false;
  final _titreController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final Color _darkGreen = Color(0xFF006400);
  final electionService = ElectionService();
  String? _startError;
  String? _endError;

  createElection() async {
      setState(() {
        loading = true;
      });
      try {
        print(_startDate);
        Map<String, dynamic> data = {
          'name': _titreController.text,
          'start_date': _startDateController.text,
          'end_date': _endDateController.text,
        };
        final response = await electionService.create(data);

        if (response["success"]){
          // Election election = Election.fromJson(response["body"]);
          // context.push("/detail_election/${election.id}");
          context.push("/dashboard_vote");
          Fluttertoast.showToast(msg: response["message"]);

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
            if (errors["start_date"]!=null){
            _startError =errors["start_date"][0].toString();
            }
            if (errors["end_date"]!=null){
              _endError = errors["end_date"][0].toString();
            }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildVoteForm(),
                  _buildCreateButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section 1 : Bouton de retour et titre "Créer une élection"
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Action pour retourner en arrière à mettre ici
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 8),
          Text(
            "Créer une élection", // Changement du titre
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Section 3 : Formulaire de vote
  Widget _buildVoteForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: _darkGreen,
            child: Text(
              "Élection", // Changement du titre
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Titre",
            ),
            controller: _titreController,
          ),
          SizedBox(height: 16),
          // Champ pour la date de début avec sélecteur de date
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _startDateController.text = formattedDate; // Afficher la date formatée dans le champ
                });
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Date de début",
                errorText: _startError,
              ),
              child: Text(
                _startDateController.text != ""
                    ? _startDateController.text
                    : "Sélectionnez une date",
              ),

            ),
          ),
          SizedBox(height: 16),
          // Champ pour la date de fin avec sélecteur de date
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _endDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  _endDateController.text = formattedDate; // Afficher la date formatée dans le champ
                });
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Date de fin",
                errorText: _endError,
              ),
              child: Text(
                _endDateController.text != ""
                    ? _endDateController.text
                    : "Sélectionnez une date",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section 6 : Bouton de création
  Widget _buildCreateButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _darkGreen,
            minimumSize: Size(200, 50),
          ),
          onPressed: createElection,
          //     () {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         content: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Icon(Icons.check_circle, color: _darkGreen, size: 50),
          //             SizedBox(height: 16),
          //             Text(
          //                 "Votre élection a bien été créée ! Optivote vous permet de la suivre."),
          //           ],
          //         ),
          //         actions: [
          //           TextButton(
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //             child: Text("OK"),
          //           ),
          //         ],
          //       );
          //     },
          //   );
          // },
          child:!loading? Text(
            "Créer l'élection", // Changement du texte du bouton
            style: TextStyle(color: Colors.white),
          ): SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

