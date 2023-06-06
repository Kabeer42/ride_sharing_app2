import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Wellcome to Home Page",
          style: TextStyle(fontSize: 25),
        ),
      )),
    );
  }
}
