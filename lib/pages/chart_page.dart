import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../widgets/line_chart.dart';
import 'package:aquanet_mobile/widgets/summary.dart';
import 'package:aquanet_mobile/widgets/custom_list_item.dart';
import 'package:flutter/services.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      FeatherIcons.chevronLeft,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FeatherIcons.thermometer, size: 50),
                        SizedBox(width: 10),
                        Text(
                          "30",
                          style: TextStyle(
                            fontSize: 75,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "°C",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "High",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w200,
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Min : 20",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 50),
                        Text(
                          "Max : 30",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SummaryContent(),
                    SizedBox(height: 60),
                    SizedBox(
                      height: 400,
                      child: LineChartWidget(
                        dataPoints: const [
                          FlSpot(0, 1),
                          FlSpot(1, 2.3),
                          FlSpot(2, double.nan),
                          FlSpot(3, 3.2),
                          FlSpot(4, 2.7),
                          FlSpot(5, double.infinity),
                          FlSpot(6, 3.3),
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
                    Row(
                      children: [
                        Text(
                          "History",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (_, index) => MinimListItem(
                        title: "25",
                        status: "Average",
                        date: "2025-06-31 13:34 25",
                        unit: "°C",
                      ),
                    ),
                    SizedBox(height: 30),
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
