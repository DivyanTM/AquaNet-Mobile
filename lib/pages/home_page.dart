import 'package:aquanet_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:aquanet_mobile/widgets/bottom_nav.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aquanet_mobile/widgets/home_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aquanet_mobile/states/globalState.dart';

import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Color(0xFFF5F6FA),
        statusBarColor: const Color(0xFFFDFDFB),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),
      backgroundColor: const Color(0xFFFDFDFB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        FeatherIcons.droplet,
                        size: 40,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "AquaNet",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      GlobalState().clearPrefs();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Icon(
                      FeatherIcons.user,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 20.0,
                  percent: 0.8,
                  animateToInitialPercent: true,
                  center: new Text(
                    "80",
                    style: TextStyle(
                      fontSize: 65,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  progressColor: Colors.greenAccent,
                  startAngle: 0,
                  backgroundColor: Colors.greenAccent.withOpacity(0.1),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Good",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                SensorBox(
                  title: "Temperature",
                  value: "26.5°C",
                  icon: FeatherIcons.thermometer,
                  textcolor: Colors.black,
                ),
                SensorBox(
                  title: "Turbidity",
                  value: "5.2 NTU",
                  icon: FeatherIcons.droplet,
                  textcolor: Colors.orangeAccent,
                ),
                SensorBox(
                  title: "Conductivity",
                  value: "0.89 µS/cm",
                  icon: FeatherIcons.zap,
                  textcolor: Colors.redAccent,
                ),
                SensorBox(
                  title: "pH",
                  value: "7.1",
                  icon: Icons.science_outlined,
                  textcolor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          }
        },
      ),
    );
  }
}
