import 'package:aquanet_mobile/states/globalState.dart';
import 'package:flutter/material.dart';
import 'package:aquanet_mobile/pages/history_page.dart';
import 'package:aquanet_mobile/pages/SplashScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GlobalState().loadPrefs();
    final isLoggedIn = GlobalState().isLoggedIn;
    runApp(MyApp(isLoggedIn: isLoggedIn));
  } catch (err) {
    print('$err');
    runApp(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          body: Center(child: Text('Application initialization failed: $err')),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaNet',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Splashscreen(),
    );
  }
}
