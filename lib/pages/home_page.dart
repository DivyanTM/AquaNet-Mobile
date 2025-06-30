import 'dart:convert';
import 'dart:ffi';

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
import 'package:aquanet_mobile/services/sensor_data_service.dart';

import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService dataService = DataService();
  int _selectedIndex = 0;
  bool isLoading = true;
  Map<String, dynamic> data = {
    "ph": 0,
    "temperature": 0,
    "turbidity": 0,
    "conductivity": 0,
  };
  int score = 0;
  double percent = 0;
  String status = "Poor";

  Future<void> _fetch() async {
    final latest = await dataService.fetchLatest();

    final tempScore = dataService.calculateWaterQualityScore(
      ph: (latest['ph'] as num).toDouble(),
      temperature: (latest['temperature'] as num).toDouble(),
      conductivity: (latest['conductivity'] as num).toDouble(),
      turbidity: (latest['turbidity'] as num).toDouble(),
    );

    setState(() {
      data = latest;
      score = tempScore;
      percent = score / 100.0;

      if (score > 80) {
        status = "Good";
      } else if (score > 60 && score <= 80) {
        status = "Moderate";
      } else {
        status = "Poor";
      }
      isLoading = false;
    });

    print("Score : $score");
    print("Status : $status");
  }

  Color getSensorColor({
    required double value,
    required double lowerLimit,
    required double upperLimit,
    double margin = 1.0,
  }) {
    if (value >= lowerLimit && value <= upperLimit) {
      return Colors.black;
    }
    if ((value >= lowerLimit - margin && value < lowerLimit) ||
        (value > upperLimit && value <= upperLimit + margin)) {
      return Colors.orangeAccent;
    }
    return Colors.redAccent;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFDFDFB),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: const Color(0xFFFDFDFB),
            body: Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            ),
          )
        : Scaffold(
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
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
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
                        percent: percent,
                        animateToInitialPercent: true,
                        center: new Text(
                          "${score}",
                          style: TextStyle(
                            fontSize: 65,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        progressColor: status == "Good"
                            ? Colors.greenAccent
                            : status == "Moderate"
                            ? Colors.orangeAccent
                            : Colors.redAccent,
                        startAngle: 0,
                        backgroundColor: status == "Good"
                            ? Colors.greenAccent.withOpacity(0.1)
                            : status == "Moderate"
                            ? Colors.orangeAccent.withOpacity(0.1)
                            : Colors.redAccent.withOpacity(0.1),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "${status}",
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
                    children: [
                      SensorBox(
                        title: "Temperature",
                        value: "${data["temperature"]}°C",
                        icon: FeatherIcons.thermometer,
                        textcolor: getSensorColor(
                          value: (data['temperature'] as num).toDouble(),
                          lowerLimit: 20.0,
                          upperLimit: 30.0,
                          margin: 1.0,
                        ),
                      ),
                      SensorBox(
                        title: "Turbidity",
                        value: "${data["turbidity"]} NTU",
                        icon: FeatherIcons.droplet,
                        textcolor: getSensorColor(
                          value: (data['turbidity'] as num).toDouble(),
                          lowerLimit: 0.0,
                          upperLimit: 5.0,
                          margin: 1.0,
                        ),
                      ),
                      SensorBox(
                        title: "Conductivity",
                        value: "${data["conductivity"]} µS/cm",
                        icon: FeatherIcons.zap,
                        textcolor: getSensorColor(
                          value: (data['conductivity'] as num).toDouble(),
                          lowerLimit: 300.0,
                          upperLimit: 800.0,
                          margin: 20.0,
                        ),
                      ),
                      SensorBox(
                        title: "pH",
                        value: "${data["ph"]}",
                        icon: Icons.science_outlined,
                        textcolor: getSensorColor(
                          value: (data['ph'] as num).toDouble(),
                          lowerLimit: 6.5,
                          upperLimit: 8.5,
                          margin: 0.5,
                        ),
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
