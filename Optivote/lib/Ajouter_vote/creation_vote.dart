import 'package:flutter/material.dart';

class CreateVotePage extends StatefulWidget {
  @override
  _CreateVotePageState createState() => _CreateVotePageState();
}

class _CreateVotePageState extends State<CreateVotePage> {
  DateTime _selectedDay = DateTime.now(); // Jour sélectionné
  DateTime _currentMonth = DateTime.now(); // Mois actuellement affiché
  int minAge = 18; // Âge minimum requis pour voter
  String location = ""; // Localisation des votants

  final Color _darkGreen = Color(0xFF006400);

  // Liste des jours de la semaine
  final List<String> _daysOfWeek = [
    "Lun",
    "Mar",
    "Mer",
    "Jeu",
    "Ven",
    "Sam",
    "Dim"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildCalendar(),
            _buildVoteForm(),
            _buildVotersSection(),
            _buildVoteOptions(),
            _buildCreateButton(),
            _buildHomeBanner(),
          ],
        ),
      ),
    );
  }

  // Section 1 : Bouton de retour et titre "Créer un vote"
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
            "Créer un vote",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Section 2 : Calendrier défilant
  Widget _buildCalendar() {
    // Nombre de jours dans le mois actuel
    int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    // Premier jour du mois
    DateTime firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);

    // Jour de la semaine du premier jour du mois (0 = Lundi, 6 = Dimanche)
    int startingWeekday = firstDayOfMonth.weekday - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Mois et année avec flèches de navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
              ),
              Text(
                "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month + 1);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          // Grille des jours de la semaine et des dates
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: _daysOfWeek.length + daysInMonth + startingWeekday,
            itemBuilder: (context, index) {
              if (index < _daysOfWeek.length) {
                // Afficher les jours de la semaine
                return Center(
                  child: Text(
                    _daysOfWeek[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              } else if (index < _daysOfWeek.length + startingWeekday) {
                // Cases vides avant le premier jour du mois
                return Container();
              } else {
                // Afficher les jours du mois
                int day = index - _daysOfWeek.length - startingWeekday + 1;
                bool isSelected = _selectedDay.day == day &&
                    _selectedDay.month == _currentMonth.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = DateTime(
                          _currentMonth.year, _currentMonth.month, day);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected ? _darkGreen : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
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
              "Vote",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}",
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Titre"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Description"),
          ),
          DropdownButtonFormField<String>(
            items: ["Type 1", "Type 2", "Type 3"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              // Action pour sélectionner un type
            },
            decoration: InputDecoration(labelText: "Type"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Date de fin"),
          ),
        ],
      ),
    );
  }

  // Section 4 : Section des votants
  Widget _buildVotersSection() {
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
              "Votants",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text("Âge minimum : "),
              IconButton(
                icon: Icon(Icons.arrow_drop_up),
                onPressed: () {
                  setState(() {
                    minAge++;
                  });
                },
              ),
              Text("$minAge"),
              IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  setState(() {
                    minAge--;
                  });
                },
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Localisation"),
            onChanged: (value) {
              setState(() {
                location = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // Section 5 : Options de vote
  Widget _buildVoteOptions() {
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
              "Options de vote",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(decoration: InputDecoration(labelText: "Option 1")),
          TextFormField(decoration: InputDecoration(labelText: "Option 2")),
          TextFormField(decoration: InputDecoration(labelText: "Option 3")),
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
                          "Votre vote a bien été créé ! Optivote vous permet de le suivre."),
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
            "Créer le vote",
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
            BorderRadius.vertical(top: Radius.circular(20)), // Bords arrondis
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
                  // Action pour retourner à l'accueil
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour obtenir le nom du mois
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "Janvier";
      case 2:
        return "Février";
      case 3:
        return "Mars";
      case 4:
        return "Avril";
      case 5:
        return "Mai";
      case 6:
        return "Juin";
      case 7:
        return "Juillet";
      case 8:
        return "Août";
      case 9:
        return "Septembre";
      case 10:
        return "Octobre";
      case 11:
        return "Novembre";
      case 12:
        return "Décembre";
      default:
        return "";
    }
  }
}
