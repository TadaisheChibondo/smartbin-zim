import 'package:flutter/material.dart';

class ReportDumpingScreen extends StatefulWidget {
  const ReportDumpingScreen({super.key});

  @override
  State<ReportDumpingScreen> createState() => _ReportDumpingScreenState();
}

class _ReportDumpingScreenState extends State<ReportDumpingScreen> {
  String selectedSeverity = "Moderate";

  bool anonymous = false;
  bool notifyCouncil = true;
  bool urgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report Illegal Dumping",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Help clean Zimbabwe",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Evidence Photo
            const Text(
              "EVIDENCE PHOTO",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7F1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                    color: Colors.green,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Upload or Take Photo",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Required for verification",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Location
            const Text(
              "LOCATION",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Text("📍", style: TextStyle(fontSize: 28)),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mbare, Harare",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "-17.8625, 31.0475 • GPS Active",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  OutlinedButton(onPressed: () {}, child: const Text("Change")),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Description
            const Text(
              "DESCRIPTION",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    "Describe what you see — waste type, estimated volume, hazards...",
                filled: true,
                fillColor: const Color(0xFFF4F4F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Severity
            const Text(
              "SEVERITY LEVEL",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _severityCard(
                    title: "Low",
                    subtitle: "Minor litter",
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _severityCard(
                    title: "Moderate",
                    subtitle: "Significant dumping",
                    color: Colors.orange,
                    selected: true,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _severityCard(
                    title: "Critical",
                    subtitle: "Hazardous waste",
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: anonymous,
                  onChanged: (v) {
                    setState(() => anonymous = v!);
                  },
                ),
                const Text("Anonymous"),

                Checkbox(
                  value: notifyCouncil,
                  onChanged: (v) {
                    setState(() => notifyCouncil = v!);
                  },
                ),
                const Text("Notify Council"),

                Checkbox(
                  value: urgent,
                  onChanged: (v) {
                    setState(() => urgent = v!);
                  },
                ),
                const Text("Urgent"),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // Submit Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Submit report logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Submit Report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _severityCard({
    required String title,
    required String subtitle,
    required Color color,
    bool selected = false,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? color : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
