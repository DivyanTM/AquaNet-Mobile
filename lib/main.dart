import 'package:flutter/material.dart';
// import 'package:aquanet_mobile/pages/home_page.dart';
// import 'package:aquanet_mobile/pages/chart_page.dart';
import 'package:aquanet_mobile/pages/history_page.dart';
import 'package:aquanet_mobile/pages/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Splashscreen(),
    );
  }
}
