import 'package:aquanet_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/services.dart';
import 'package:aquanet_mobile/widgets/history_tile.dart';

import '../widgets/bottom_nav.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final int _selectedIndex = 1;

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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  HistoryTile(
                    title: "25",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "24",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                  HistoryTile(
                    title: "22",
                    ph: "7.5",
                    temperature: "45",
                    conductivity: "344",
                    turbidity: "34",
                  ),
                ],
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
