import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: MediaQuery.of(context).size.width > 640
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //logo
            //auth input email & password
            //buttons: login & signup
          ],
        ),
      ),
    ));
  }
}
