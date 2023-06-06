import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing_app/widgets.dart';

import 'DriverHomePage.dart';

class DriverInfo extends StatefulWidget {
  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        goBackScreen(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome to GoRide!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1.5,
                      letterSpacing: 1),
                ),
                Text(
                  "Let\'s get acquainted",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16.5),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'First name',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Last name',
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'CNIC',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Vehicle Type',
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Vehicle No plate',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 45.0),
                SizedBox(
                  height: 45,
                  width: 350,
                  child: ElevatedButton(
                      onPressed: () {
                        nextScreen(context, DriverHomeScreen());
                      },
                      child: Text("Next")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
