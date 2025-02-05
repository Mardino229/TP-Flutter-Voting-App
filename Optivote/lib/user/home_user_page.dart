import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeUserPage extends StatelessWidget {
  // Couleur personnalisée pour la bannière
  final Color _darkGreen =
      Color.fromARGB(255, 23, 98, 28); // Exemple de couleur verte foncée

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/Group 1000003744.png', // Chemin de ton logo
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrousel de cartes
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Nombre de cartes dans le carrousel
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Bords arrondis
                    ),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(20), // Bords arrondis
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/image 1.png'), // Chemin de l'image
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Centrer le texte
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Centrer le texte
                          children: [
                            Text(
                              "Élection $index",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Centrer le texte
                            ),
                            SizedBox(
                                height:
                                    8), // Espacement entre le titre et la description
                            Text(
                              "Description de l'élection $index",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center, // Centrer le texte
                            ),
                            SizedBox(height: 16), // Espacement avant les icônes
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Centrer les icônes
                              children: [
                                Icon(Icons.thumb_up,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "${100 + index} votes",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                    width: 16), // Espacement entre les icônes
                                Icon(Icons.timer,
                                    color: Colors.white, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Boutons Créer vote et Filtrer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Créer vote"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Filtrer"),
                  ),
                ],
              ),
            ),
            // Titre Nouveaux scrutins
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nouveaux scrutins",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Liste des nouveaux scrutins
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Nombre de scrutins
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Naviguer vers la page de détail
                    Navigator.pushNamed(
                      context,
                      '/detail_vote',
                      arguments: {
                        'title': "Élection Municipale 2025",
                        'description': "Description de l'élection $index",
                        'votes': 50 + index,
                        'deadline': "2025-05-20",
                        'imageUrl': 'assets/image 1.png',
                      },
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bords arrondis
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Bords arrondis pour l'image
                            child: Image.asset(
                              'assets/image 1.png', // Chemin de l'image
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Élection Municipale 2025",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Description de l'élection $index"),
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up, size: 16),
                                    SizedBox(width: 4),
                                    Text("${50 + index} votes"),
                                    Spacer(),
                                    Icon(Icons.timer, size: 16),
                                    SizedBox(width: 4),
                                    Text("2025-05-20"),
                                  ],
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
            ),
          ],
        ),
      ),
      // Bannière en bas avec le widget personnalisé
      bottomNavigationBar: _buildHomeBanner(),
    );
  }

  // Widget pour la bannière en bas
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
