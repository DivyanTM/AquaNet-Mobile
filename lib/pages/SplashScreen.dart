// import 'package:aquanet_mobile/pages/home_page.dart';
import 'package:aquanet_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/cupertino.dart';
// import 'package:aquanet_mobile/pages/register_page.dart';
import 'package:aquanet_mobile/pages/login_page.dart';

import '../states/globalState.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final isLoggedIn = GlobalState().isLoggedIn;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.lightBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const HomePage() : const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FeatherIcons.droplet, size: 70, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "AquaNet",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            CupertinoActivityIndicator(color: Colors.white, radius: 20),
          ],
        ),
      ),
    );
  }
}
