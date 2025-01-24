import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDateIndex = 0;
  final dates = ["Lun 13", "Mar 14", "Mer 15", "Jeu 16", "Ven 17", "Sam 18", "Dim 19"];
  final events = [
    {"time": "10:00", "title": "Élection municipale 2025", "duration": "10:00 - 12:00"},
    {"time": "14:00", "title": "Réunion générale", "duration": "14:00 - 15:30"},
    {"time": "16:00", "title": "Conférence de presse", "duration": "16:00 - 17:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novembre 2024"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar Row
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            color: Colors.green[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(dates.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedDateIndex == index ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      dates[index],
                      style: TextStyle(
                        color: selectedDateIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Create Vote Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Créer un vote"),
            ),
          ),
          // Events List
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  leading: Text(event["time"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text(event["title"]!),
                  subtitle: Text(event["duration"]!),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Événements"),
        ],
        selectedItemColor: Colors.green,
      ),
    );
  }
}
