import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SeeAllVotes extends StatefulWidget {
  const SeeAllVotes({super.key});

  @override
  State<SeeAllVotes> createState() => _SeeAllVotesState();
}

class _SeeAllVotesState extends State<SeeAllVotes> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    DateTime currentMonth = DateTime.now();
    List<List<String>> weekday =getFormattedDatesOfWeek(currentMonth);
    List<String> nomElection = ["Election municipale 2025","Election miss UAC 2025","Election responsable 2025","Election miss 2025","Election législative 2025","Election presidentielle 2026"];
    List<String> periode=["10:00-12:00","10:00-12:00","10:00-12:00","10:00-12:00","10:00-12:00","10:00-12:00"];


    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.32,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image 1.png",),
                  opacity: 0.89,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40),)
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new,color:Colors.white),
                      onPressed: () {
                        setState(() {
                          currentMonth =
                              DateTime(currentMonth.year, currentMonth.month - 1);
                        });
                      },
                    ),
                    Text(
                      "${_getMonthName(currentMonth.month)} ${currentMonth.year}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_outlined,color:Colors.white),
                      onPressed: () {
                        setState(() {
                          currentMonth =
                              DateTime(currentMonth.year, currentMonth.month + 1);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.025,),
                SingleChildScrollView(
                  //scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      weekday.length,
                          (index) =>
                            Container(
                              width: screenWidth*0.13,
                              height: screenHeight*0.08,
                              decoration: BoxDecoration(border: Border.all(
                                color: weekday[index][2]=="false"? Colors.white:Colors.black, // Couleur de la bordure
                                width: 2.0, // Épaisseur de la bordure
                              ),
                              color: weekday[index][2]=="false"? Colors.transparent:Colors.white,
                              borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                children: [
                                  SizedBox(height: screenHeight*0.025,),
                                  Text("${weekday[index][0]}\n ${weekday[index][1]}",style: TextStyle(fontSize: screenWidth*0.025,color:weekday[index][2]=="false"? Colors.white:Colors.black),textAlign: TextAlign.center,),
                                ],
                              )

                            )

                      ),
                  ),
                ),
                SizedBox(height: screenHeight*0.025,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Color.fromRGBO(255, 255, 255, 1)),
                    elevation: WidgetStateProperty.all(0),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: BorderSide(color: Color(0xFF707070), width: 1),
                      ),
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    fixedSize: WidgetStateProperty.all(Size(screenWidth * 0.8,
                        screenHeight * 0.065)), // Taille fixe
                  ),
                  onPressed: () {
                    context.push("/creation_vote");
                  },
                  child: Text(
                    "Créer un vote",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ]
            ),

          ),
          SizedBox(
            height: screenHeight*0.6,
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.05,),
                Text("${weekday[2][0]} ${weekday[2][1]} ${_getMonthName(currentMonth.month)} ${currentMonth.year}",style: TextStyle(fontSize: screenWidth*0.04,color:Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                SizedBox(
                  height: screenHeight*0.5,
                  width: screenWidth*0.8,
                  child:SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        nomElection.length,
                            (index) => Card(
                          color: Color.fromRGBO(
                              153, 238, 178, 0.1411764705882353),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(nomElection[index],style: TextStyle(fontSize: screenWidth*0.06,fontWeight: FontWeight.bold),),
                                  SizedBox(height: screenHeight*0.015,),
                                  Text(periode[index],style: TextStyle(fontSize: screenWidth*0.04,)),
                                  SizedBox(height: screenHeight*0.015,),
                                  Text("Vote unique",style: TextStyle(fontSize: screenWidth*0.04,)),
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                ,
              ],
            ),
          ),

        ]
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
  List<List<String>> getFormattedDatesOfWeek(DateTime currentDate) {
    // Tableau des noms des jours en français
    List<String> jours = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];

    // Générer les 7 jours de la semaine
    List<List<String>> formattedDates = [];
    for (int i = -2; i < 3; i++) {
      DateTime day = currentDate.add(Duration(days: i));
      List<String> formattedDate = [jours[day.weekday - 1],"${day.day}",i==0? "true":"false"];
      formattedDates.add(formattedDate);
    }

    return formattedDates;
  }
}
