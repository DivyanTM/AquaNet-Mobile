import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aquanet_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:aquanet_mobile/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../widgets/auth_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool canLogin = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(FeatherIcons.chevronLeft),
                  iconSize: 26,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
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
                        icon: FeatherIcons.mail,
                        hintText: "E-Mail",
                        controller: _emailController,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        icon: FeatherIcons.phone,
                        hintText: "Phone Number",
                        controller: _phoneNumberController,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        icon: FeatherIcons.lock,
                        hintText: "Password",
                        controller: _passwordController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CupertinoCheckbox(
                            value: canLogin,
                            onChanged: (value) {
                              setState(() {
                                canLogin = value!;
                              });
                            },
                          ),
                          const Text(
                            "I agree to ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Text(
                            "Privacy Policy ",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent,
                            ),
                          ),
                          const Text(
                            "and ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Text(
                            "Terms of Use",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoButton.filled(
                              color: CupertinoColors.activeBlue,
                              child: Text("Create Account"),
                              onPressed: () async {
                                if (_usernameController.text.isEmpty &&
                                    _emailController.text.isEmpty &&
                                    _phoneNumberController.text.isEmpty &&
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
                                if (_emailController.text.isEmpty) {
                                  return showCustomToast(
                                    context,
                                    "Please enter email",
                                    ToastType.error,
                                  );
                                }
                                if (_phoneNumberController.text.isEmpty) {
                                  return showCustomToast(
                                    context,
                                    "Please enter phone number",
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
                                if (!canLogin) {
                                  return showCustomToast(
                                    context,
                                    "Please agree to privacy policy and terms of use",
                                    ToastType.error,
                                  );
                                }

                                try {
                                  final response = await LoginService()
                                      .register(
                                        _usernameController.text.trim(),
                                        _emailController.text.trim(),
                                        _phoneNumberController.text.trim(),
                                        _passwordController.text.trim(),
                                      );

                                  print(response['user']);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Registration Successful'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                } catch (e) {
                                  String errorMessage =
                                      "Registration failed. Please try again later.";
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
                                        "Invalid credentials format.";
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
