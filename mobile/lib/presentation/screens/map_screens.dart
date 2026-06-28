import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WasteHotspotMapScreen extends StatefulWidget {
  const WasteHotspotMapScreen({super.key});

  @override
  State<WasteHotspotMapScreen> createState() => _WasteHotspotMapScreenState();
}

class _WasteHotspotMapScreenState extends State<WasteHotspotMapScreen> {
  GoogleMapController? mapController;

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-17.8292, 31.0522), // Harare
    zoom: 11,
  );

  final Set<Marker> markers = {
    Marker(
      markerId: MarkerId("mbare"),
      position: LatLng(-17.8625, 31.0475),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: "Mbare Market",
        snippet: "47 reports - Critical",
      ),
    ),

    Marker(
      markerId: MarkerId("bulawayo"),
      position: LatLng(-17.8210, 31.1000),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: "Bulawayo Street",
        snippet: "38 reports - Critical",
      ),
    ),

    Marker(
      markerId: MarkerId("highfield"),
      position: LatLng(-17.8900, 30.9800),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(
        title: "Highfield",
        snippet: "31 reports - Moderate",
      ),
    ),

    Marker(
      markerId: MarkerId("clean"),
      position: LatLng(-17.7500, 31.1500),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: "Clean Area",
        snippet: "No dumping detected",
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Waste Hotspot Map",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Zimbabwe • Live AI monitoring",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "LIVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _filterChip("All", true),
                    const SizedBox(width: 10),
                    _filterChip("Critical", false),
                    const SizedBox(width: 10),
                    _filterChip("Moderate", false),
                    const SizedBox(width: 10),
                    _filterChip("Clean", false),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 420,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: initialPosition,
                      markers: markers,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                    ),

                    Positioned(
                      right: 15,
                      top: 15,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(blurRadius: 8, color: Colors.black12),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AI Predicted",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "+3 hotspots",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "next 48h",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Icon(Icons.circle, color: Colors.red, size: 16),
                    SizedBox(width: 5),
                    Text("Critical"),

                    SizedBox(width: 20),

                    Icon(Icons.circle, color: Colors.orange, size: 16),
                    SizedBox(width: 5),
                    Text("Moderate"),

                    SizedBox(width: 20),

                    Icon(Icons.circle, color: Colors.green, size: 16),
                    SizedBox(width: 5),
                    Text("Clean"),

                    Spacer(),

                    Text(
                      "247 total reports",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "TOP HOTSPOTS",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              hotspotTile("Mbare Market", "47 reports • critical", Colors.red),

              hotspotTile("Bulawayo S.", "38 reports • critical", Colors.red),

              hotspotTile("Highfield", "31 reports • high", Colors.orange),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget _filterChip(String title, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget hotspotTile(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(Icons.circle, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.circle, color: color, size: 16),
        ],
      ),
    );
  }
}
