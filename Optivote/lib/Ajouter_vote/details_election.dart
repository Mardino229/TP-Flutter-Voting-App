import 'package:flutter/material.dart';
import 'package:optivote/Ajouter_vote/tour2.dart';
import 'package:optivote/pages/addCandidat.dart';

class ElectionDetailsScreen extends StatefulWidget {
  const ElectionDetailsScreen({super.key});

  @override
  State<ElectionDetailsScreen> createState() => _ElectionDetailsScreenState();
}

class _ElectionDetailsScreenState extends State<ElectionDetailsScreen> {
  // État pour le timer
  String _timerValue = '12:00:00';
  // État pour le nombre de votants
  int _votersCount = 126;
  // État pour les résultats
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

  bool _isVotingClosed = false;

  void _closeVoting() {
    setState(() {
      _isVotingClosed = true;
    });
    // Ajouter ici la logique pour clôturer le vote
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Election municipale 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '11/11/2024 au 11/12/2024',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGridItem(
<<<<<<< Updated upstream
                        icon: Icons.timer,
                        title: _timerValue,
                        isActive: !_isVotingClosed,
                      ),
                      _buildGridItem(
                        icon: Icons.people,
                        title: '$_votersCount votants',
=======
                        icon: Icons.hourglass_empty,
                        title: "${electionDetails.delay}",
                        isActive: !_isVotingClosed,
                      ),
                      _buildGridItem(
                        icon: Icons.person_outlined,
                        title: '${electionDetails.nbrVote} votants',
>>>>>>> Stashed changes
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGridItem(
                        title: 'Option en tete',
                        showTrophy: true,
                      ),
                      _buildGridItem(
                        title: '2e option en tete',
                        showTrophy2: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
<<<<<<< Updated upstream
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isVotingClosed ? null : _closeVoting,
                      icon: const Icon(Icons.close),
                      label: Text(_isVotingClosed
                          ? 'Vote clôturé'
                          : 'Cloturer le scrutin'),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeuxiemeTourScreen()),
                        );
                      },
                      label: Text(
                        'Deuxième tour',
                        style: TextStyle(
=======
                  Row(children: [
                    SizedBox(
                      width: screenWidth*0.35,
                      child: ElevatedButton.icon(
                        onPressed: _isVotingClosed ? null : ()=>_showDeleteDialog(context),
                        icon: const Icon(
                          Icons.close,
>>>>>>> Stashed changes
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
                    const SizedBox(width: 20),
                    SizedBox(
                      width:  screenWidth*0.35,
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

                  ],),


                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _voteOptions.length,
                      itemBuilder: (context, index) =>
                          _buildResultCard(_voteOptions[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCandidat()),
          );
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

  Widget _buildResultCard(VoteOption option) {
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
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 16),
                Text(
                  option.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              option.details,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${option.votes} votes/${option.totalVotes}'),
                Text(
                  '${(option.votes / option.totalVotes * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: option.votes / option.totalVotes,
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
