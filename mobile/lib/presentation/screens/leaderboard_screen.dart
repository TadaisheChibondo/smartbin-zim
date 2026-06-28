import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              height: 320,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF00B894)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white24,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),

                        const SizedBox(width: 20),

                        const Text(
                          "Community Leaderboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        podiumCard(
                          medal: "🥈",
                          title: "Harare High School",
                          rank: "2nd",
                          height: 120,
                        ),

                        const SizedBox(width: 20),

                        podiumCard(
                          medal: "🥇",
                          title: "Prince Edward High",
                          rank: "1st",
                          height: 180,
                          isWinner: true,
                        ),

                        const SizedBox(width: 20),

                        podiumCard(
                          medal: "🥉",
                          title: "St. Georges College",
                          rank: "3rd",
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: categoryChip("🎓 Schools", true)),

                  const SizedBox(width: 10),

                  Expanded(child: categoryChip("🏛 Universities", false)),

                  const SizedBox(width: 10),

                  Expanded(child: categoryChip("🏘 Communities", false)),
                ],
              ),
            ),

            // Ranking List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  RankTile(
                    rankIcon: "🥇",
                    school: "Prince Edward High",
                    points: "12 480 pts",
                    movement: "+2",
                    positive: true,
                  ),

                  RankTile(
                    rankIcon: "🥈",
                    school: "Harare High School",
                    points: "11 250 pts",
                    movement: "—",
                    positive: true,
                  ),

                  RankTile(
                    rankIcon: "🥉",
                    school: "St. Georges College",
                    points: "9 870 pts",
                    movement: "+1",
                    positive: true,
                  ),

                  RankTile(
                    rankIcon: "#4",
                    school: "Arundel School",
                    points: "8 640 pts",
                    movement: "-1",
                    positive: false,
                  ),

                  RankTile(
                    rankIcon: "#5",
                    school: "Churchill High",
                    points: "7 230 pts",
                    movement: "+3",
                    positive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Rewards",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  static Widget categoryChip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget podiumCard({
    required String medal,
    required String title,
    required String rank,
    required double height,
    bool isWinner = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(medal, style: const TextStyle(fontSize: 32)),

        const SizedBox(height: 10),

        Container(
          width: 110,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.15),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          rank,
          style: TextStyle(
            color: isWinner ? Colors.amber : Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}

class RankTile extends StatelessWidget {
  final String rankIcon;
  final String school;
  final String points;
  final String movement;
  final bool positive;

  const RankTile({
    super.key,
    required this.rankIcon,
    required this.school,
    required this.points,
    required this.movement,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade100,
              child: Text(rankIcon, style: const TextStyle(fontSize: 24)),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    school,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    points,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              movement,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: positive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
