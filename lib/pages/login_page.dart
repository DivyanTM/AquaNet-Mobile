import 'dart:async';
import 'dart:io';

import 'package:aquanet_mobile/pages/home_page.dart';
import 'package:aquanet_mobile/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:aquanet_mobile/widgets/toast.dart';
import 'package:aquanet_mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/auth_input.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Icon(FeatherIcons.chevronLeft, size: 26),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 40),
                    Text(
                      "SignIn to Continue",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomInputField(
                      icon: FeatherIcons.user,
                      hintText: "Username",
                      controller: _usernameController,
                    ),
                    SizedBox(height: 10),
                    CustomInputField(
                      icon: FeatherIcons.lock,
                      hintText: "Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton.filled(
                            color: CupertinoColors.activeBlue,
                            child: Text("Sign In"),
                            onPressed: () async {
                              if (_usernameController.text.isEmpty &&
                                  _passwordController.text.isEmpty) {
                                return showCustomToast(
                                  context,
                                  "Please fill all fields",
                                  ToastType.error,
                                );
                              }
                              if (_usernameController.text.isEmpty) {
                                return showCustomToast(
                                  context,
                                  "Please enter username",
                                  ToastType.error,
                                );
                              }
                              if (_passwordController.text.isEmpty) {
                                return showCustomToast(
                                  context,
                                  "Please enter password",
                                  ToastType.error,
                                );
                              }
                              try {
                                final response = await LoginService().login(
                                  _usernameController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', true);

                                prefs.setString(
                                  'user',
                                  jsonEncode(response['user']),
                                );

                                print(response['user']);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Login Successful'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } catch (e) {
                                String errorMessage =
                                    "Login failed. Please try again later.";
                                bool isUnknown = false;
                                print(e);
                                if (e is TimeoutException) {
                                  errorMessage =
                                      "Network timeout. Please check your connection.";
                                } else if (e is SocketException) {
                                  errorMessage =
                                      "No internet connection. Please check your network.";
                                } else if (e is FormatException) {
                                  errorMessage =
                                      "Invalid username or password format.";
                                } else if (e.toString().contains("401")) {
                                  errorMessage =
                                      "Incorrect username or password.";
                                } else if (e.toString().contains("500")) {
                                  errorMessage =
                                      "Server error. Please try again later.";
                                } else {
                                  // print("Unknown error: $e");
                                  isUnknown = true;
                                  errorMessage = e.toString().split(
                                    "Exception: ",
                                  )[1];
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
