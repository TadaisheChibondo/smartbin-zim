import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CouncilAnalyticsScreen extends StatelessWidget {
  const CouncilAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Council Analytics",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Harare City Council • Admin View",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "COUNCIL",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stats Cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: const [
                  AnalyticsCard(
                    title: "Total Reports",
                    value: "3,247",
                    change: "+18% vs last month",
                    positive: true,
                  ),
                  AnalyticsCard(
                    title: "Collection Rate",
                    value: "67%",
                    change: "+4% vs last month",
                    positive: true,
                  ),
                  AnalyticsCard(
                    title: "Active Hotspots",
                    value: "23",
                    change: "+3 vs last month",
                    positive: false,
                  ),
                  AnalyticsCard(
                    title: "Tons Collected",
                    value: "847t",
                    change: "+12% vs last month",
                    positive: true,
                  ),
                ],
              ),
            ),

            // Waste Trend
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Waste Trend",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),

                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 400),
                                FlSpot(1, 380),
                                FlSpot(2, 500),
                                FlSpot(3, 600),
                                FlSpot(4, 480),
                                FlSpot(5, 720),
                              ],
                              isCurved: true,
                            ),
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 280),
                                FlSpot(1, 300),
                                FlSpot(2, 330),
                                FlSpot(3, 290),
                                FlSpot(4, 410),
                                FlSpot(5, 500),
                              ],
                              isCurved: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Waste Composition
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Waste Composition",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 180,
                            child: PieChart(
                              PieChartData(
                                centerSpaceRadius: 45,
                                sections: [
                                  PieChartSectionData(
                                    value: 38,
                                    color: Colors.blue,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    value: 29,
                                    color: Colors.green,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    value: 18,
                                    color: Colors.orange,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    value: 9,
                                    color: Colors.purple,
                                    title: '',
                                  ),
                                  PieChartSectionData(
                                    value: 6,
                                    color: Colors.red,
                                    title: '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Expanded(
                          child: Column(
                            children: [
                              LegendItem(
                                color: Colors.blue,
                                label: "Plastic",
                                value: "38%",
                              ),
                              LegendItem(
                                color: Colors.green,
                                label: "Organic",
                                value: "29%",
                              ),
                              LegendItem(
                                color: Colors.orange,
                                label: "Paper",
                                value: "18%",
                              ),
                              LegendItem(
                                color: Colors.purple,
                                label: "Glass",
                                value: "9%",
                              ),
                              LegendItem(
                                color: Colors.red,
                                label: "Metal",
                                value: "6%",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // AI Resolutions
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "AI Resolutions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    ResolutionTile(
                      title: "Mbare Market",
                      subtitle: "Deploy 2 additional smart bins",
                    ),

                    ResolutionTile(
                      title: "Kuwadzana",
                      subtitle: "Schedule urgent waste collection",
                    ),

                    ResolutionTile(
                      title: "CBD",
                      subtitle: "Increase recycling awareness campaign",
                    ),

                    ResolutionTile(
                      title: "Highfield",
                      subtitle: "Optimize garbage truck routes",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool positive;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              change,
              style: TextStyle(color: positive ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(radius: 6, backgroundColor: color),
          const SizedBox(width: 10),
          Expanded(child: Text(label)),
          Text(value),
        ],
      ),
    );
  }
}

class ResolutionTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const ResolutionTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.auto_awesome)),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
