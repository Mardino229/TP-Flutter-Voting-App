// lib/user/detail_user.dart
import 'package:flutter/material.dart';

class DetailUser extends StatefulWidget {

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  // Couleur personnalisée pour la bannière
  final Color _darkGreen = Color(0xFF1B5E20); // Exemple de couleur verte foncée

  // Variable pour suivre la carte sélectionnée
  int _selectedIndex = 0; // Par défaut, la 3e carte est sélectionnée

  @override
  Widget build(BuildContext context) {
    // Récupérer les arguments passés lors de la navigation
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Détails du scrutin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec l'image et les informations superposées
            Stack(
              alignment: Alignment.center,
              children: [
                // Image du scrutin avec le bas arrondi
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    args['imageUrl'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                // Fond semi-transparent pour améliorer la lisibilité du texte
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                // Informations superposées sur l'image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args['title'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        args['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.thumb_up, size: 20, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            "${args['votes']} votes",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.timer, size: 20, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            args['deadline'],
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            "Vote unique",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Grille de 4 mini-cartes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildMiniCard(
                    icon: Icons.timer,
                    text: "12:00:00:01",
                    isSelected: _selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  _buildMiniCard(
                    icon: Icons.people,
                    text: "150 votants",
                    isSelected: _selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  _buildMiniCard(
                    imageUrl: 'assets/image-removebg-preview 1.png',
                    text: "Option en tête",
                    isSelected: _selectedIndex == 2,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                  ),
                  _buildMiniCard(
                    imageUrl: 'assets/Frame 1000003618.png',
                    text: "2e option en tête",
                    isSelected: _selectedIndex == 3,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Liste des options de vote (cartes au format de carte bancaire)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildVoteOptionCard(
                    title: "Option 1",
                    description: "Description de l'option 1",
                    progress: 0.75, // 75% de votes
                  ),
                  SizedBox(height: 16),
                  _buildVoteOptionCard(
                    title: "Option 2",
                    description: "Description de l'option 2",
                    progress: 0.50, // 50% de votes
                  ),
                  SizedBox(height: 16),
                  _buildVoteOptionCard(
                    title: "Option 3",
                    description: "Description de l'option 3",
                    progress: 0.25, // 25% de votes
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      // Bannière verte en bas
      bottomNavigationBar: _buildHomeBanner(),
    );
  }

  // Widget pour une mini-carte
  Widget _buildMiniCard({
    IconData? icon,
    String? imageUrl,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? _darkGreen : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      size: 40,
                      color: isSelected ? Colors.white : _darkGreen,
                    ),
                  if (imageUrl != null)
                    Image.asset(
                      imageUrl,
                      width: 40,
                      height: 40,
                    ),
                  SizedBox(height: 8),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Indicateur visuel en haut à droite
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.green : Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour une carte d'option de vote
  Widget _buildVoteOptionCard({
    required String title,
    required String description,
    required double progress,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre verte en haut (hauteur augmentée)
          Container(
            height: 20, // Hauteur augmentée
            decoration: BoxDecoration(
              color: _darkGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Carré blanc simple
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Jauge de progression
                      Row(
                        children: [
                          Text(
                            "${(progress * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey[300],
                              valueColor:
                              AlwaysStoppedAnimation<Color>(_darkGreen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour la bannière en bas
  Widget _buildHomeBanner() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: _darkGreen,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 6,
            child: Container(
              padding: EdgeInsets.all(1.5),
              decoration: BoxDecoration(
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
}