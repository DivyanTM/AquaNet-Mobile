import 'package:aquanet_mobile/pages/home_page.dart';
import 'package:aquanet_mobile/services/sensor_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/services.dart';
import 'package:aquanet_mobile/widgets/history_tile.dart';
import 'package:aquanet_mobile/models/sensor_record.dart';

import '../widgets/bottom_nav.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DataService dataService = DataService();
  final int _selectedIndex = 1;

  List<SensorRecord> historyRecords = [];

  Future<void> _fetchHistory() async {
    final List<dynamic> history = await dataService.fetchAll();

    final records = history
        .map((item) => SensorRecord.fromJson(item as Map<String, dynamic>))
        .toList();

    setState(() {
      historyRecords = records;
    });
  }

  String formatSimpleDate(String isoString) {
    final dateTime = DateTime.parse(isoString).toLocal();

    final year = dateTime.year;
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    return "$day-$month-$year, $hour12:$minute $amPm";
  }

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
    _fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),
      backgroundColor: const Color(0xFFFDFDFB),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Top Bar
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
                    "History",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Expandable List
            Expanded(
              // child: ListView(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   children: [
              //     HistoryTile(
              //       title: "25",
              //       ph: "7.5",
              //       temperature: "45",
              //       conductivity: "344",
              //       turbidity: "34",
              //     ),
              //   ],
              // ),
              child: ListView.builder(
                itemCount: historyRecords.length,
                itemBuilder: (context, index) {
                  final record = historyRecords[index];
                  return HistoryTile(
                    title: dataService
                        .calculateWaterQualityScore(
                          ph: record.ph.toDouble(),
                          temperature: record.temperature.toDouble(),
                          conductivity: record.conductivity.toDouble(),
                          turbidity: record.turbidity.toDouble(),
                        )
                        .toString(),
                    ph: record.ph.toString(),
                    temperature: record.temperature.toString(),
                    conductivity: record.conductivity.toString(),
                    turbidity: record.turbidity.toString(),
                    datetime: formatSimpleDate(
                      record.timestamp.toIso8601String(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }
}
