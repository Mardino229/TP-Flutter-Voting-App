import 'package:flutter/material.dart';

class CreateVotePage extends StatefulWidget {
  @override
  _CreateVotePageState createState() => _CreateVotePageState();
}

class _CreateVotePageState extends State<CreateVotePage> {
  DateTime? _startDate; // Date de début
  DateTime? _endDate; // Date de fin
  int minAge = 18; // Âge minimum requis pour voter
  String location = ""; // Localisation des votants

  final Color _darkGreen = Color(0xFF006400);

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
          _buildHomeBanner(), // Bannière en bas
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
            decoration: InputDecoration(labelText: "Titre"),
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
                setState(() {
                  _startDate = pickedDate;
                });
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Date de début",
              ),
              child: Text(
                _startDate != null
                    ? "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}"
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
                setState(() {
                  _endDate = pickedDate;
                });
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Date de fin",
              ),
              child: Text(
                _endDate != null
                    ? "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: _darkGreen, size: 50),
                      SizedBox(height: 16),
                      Text(
                          "Votre élection a bien été créée ! Optivote vous permet de la suivre."),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            "Créer l'élection", // Changement du texte du bouton
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Section 7 : Bannière de retour à l'accueil
  Widget _buildHomeBanner() {
    return Container(
      height: 60, // Hauteur réduite de la bannière
      decoration: BoxDecoration(
        color: _darkGreen,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(19)), // Bords arrondis
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -11,
            child: Container(
              padding: EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Icon(Icons.home, size: 40, color: Colors.black),
                onPressed: () {
                  // Navigation vers la page Welcome
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
