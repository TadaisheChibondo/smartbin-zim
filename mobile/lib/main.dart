import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SmartBinApp());
}

class SmartBinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
 routes{
  '/leaderboard':(context)=>const
   LeaderboardScreen(),
},
home: const CouncilAnalyticsScreens(),