import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B894), Color(0xFF0984E3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white24,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),

                          const SizedBox(width: 15),

                          const Expanded(
                            child: Text(
                              "Green Points Rewards",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "2 840",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "Green Points",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 24,
                              ),
                            ),

                            const SizedBox(height: 25),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gold Tier",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "660 pts to Platinum",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: 0.78,
                                minHeight: 16,
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TierItem(label: "Bronze", achieved: true),
                                TierItem(label: "Silver", achieved: true),
                                TierItem(label: "Gold", achieved: true),
                                TierItem(label: "Platinum", achieved: false),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MARKETPLACE",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            rewardCard(
              emoji: "📱",
              title: "EcoMobile Bundle",
              company: "Econet",
              tag: "Popular",
              points: "500 pts",
            ),

            rewardCard(
              emoji: "🛒",
              title: "Supermarket Voucher",
              company: "OK Zimbabwe",
              tag: "",
              points: "800 pts",
            ),

            // CHANGED ITEM
            rewardCard(
              emoji: "🚌",
              title: "Bus Pass (1 Week)",
              company: "ZUPCO Zimbabwe",
              tag: "Green",
              points: "350 pts",
            ),

            const SizedBox(height: 30),
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

  static Widget rewardCard({
    required String emoji,
    required String title,
    required String company,
    required String tag,
    required String points,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 35)),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (tag.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  company,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                points,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Redeem",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TierItem extends StatelessWidget {
  final String label;
  final bool achieved;

  const TierItem({super.key, required this.label, required this.achieved});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: achieved ? Colors.white : Colors.white24,
          child: achieved
              ? const Icon(Icons.check, color: Colors.green)
              : const Icon(
                  Icons.circle_outlined,
                  color: Colors.white54,
                  size: 18,
                ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
