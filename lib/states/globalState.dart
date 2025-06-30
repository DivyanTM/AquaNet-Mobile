import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();
  factory GlobalState() => _instance;
  GlobalState._internal();

  bool isLoggedIn = false;
  String user = '';
  String username = '';

  Future<void> loadPrefs() async {
    print("Getting SharedPreferences...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Got SharedPreferences.");
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    user = prefs.getString('user') ?? '{}';

    print(
      'from global state\n---------------------------------------------------------------------------',
    );
    print("isLoggedIn: $isLoggedIn");
    print("user: $user");
    print(
      '\n---------------------------------------------------------------------------',
    );
  }

  Future<void> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
    prefs.setString('user', user);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.user = jsonEncode(user);
    prefs.setString('user', this.user);
  }

  Future<void> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoggedIn = false;
    user = '{}';
    username = '';
  }

  Map<String, dynamic> getUser() {
    try {
      return jsonDecode(user);
    } catch (e) {
      return {};
    }
  }

  Future<void> setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = status;
    await prefs.setBool('isLoggedIn', status);
  }
}
