import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade100,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {},
                          ),
                        ),

                        const Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.grey.shade100,
                          child: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF00B894), Color(0xFF0984E3)],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "TM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Text("🏅", style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Tatenda Zimuto",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Bulawayo, Zimbabwe • Gold Tier",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        BadgeChip("🌱 Eco Warrior"),
                        BadgeChip("♻️ Top Recycler"),
                        BadgeChip("🏆 10 Scans"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.4,
                  children: const [
                    StatCard(
                      icon: "📸",
                      value: "47",
                      title: "Reports Filed",
                      valueColor: Colors.red,
                    ),

                    StatCard(
                      icon: "♻️",
                      value: "128kg",
                      title: "Waste Collected",
                      valueColor: Colors.green,
                    ),

                    StatCard(
                      icon: "⭐",
                      value: "2,840",
                      title: "Green Points",
                      valueColor: Colors.orange,
                    ),

                    StatCard(
                      icon: "🤖",
                      value: "93",
                      title: "AI Scans Done",
                      valueColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Environmental Impact
              sectionTitle("ENVIRONMENTAL IMPACT"),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("🌍", style: TextStyle(fontSize: 32)),

                            const SizedBox(width: 12),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Impact Score",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text("Top 8% in Zimbabwe"),
                                ],
                              ),
                            ),

                            const Text(
                              "94",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 40),

                        impactRow(
                          "CO₂ Prevented",
                          "equiv. 18 trees planted",
                          "234 kg",
                        ),

                        impactRow("Plastic Diverted", "from landfill", "42 kg"),

                        impactRow("Community Rank", "Bulawayo District", "#12"),
                      ],
                    ),
                  ),
                ),
              ),

              // Activity Feed
              sectionTitle("ACTIVITY FEED"),

              activityCard(
                "Submitted report — Mbare Market",
                "Today",
                "+25 pts",
                Colors.green,
              ),

              activityCard(
                "AI Scan — Plastic bottle",
                "Yesterday",
                "+15 pts",
                Colors.green,
              ),

              activityCard(
                "Community Cleanup Event",
                "2 days ago",
                "+100 pts",
                Colors.green,
              ),

              activityCard(
                "Redeemed Free ZUPCO Bus Pass",
                "3 days ago",
                "-500 pts",
                Colors.red,
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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

  static Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  static Widget impactRow(String title, String subtitle, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  static Widget activityCard(
    String title,
    String date,
    String points,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.1),
            child: const Icon(Icons.arrow_upward),
          ),
          title: Text(title),
          subtitle: Text(date),
          trailing: Text(
            points,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class BadgeChip extends StatelessWidget {
  final String text;

  const BadgeChip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color(0xFFEAF8EF),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  final Color valueColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
