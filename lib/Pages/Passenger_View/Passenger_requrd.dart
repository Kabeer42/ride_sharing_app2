import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing_app/Pages/Passenger_View/PassengerHomeScreen.dart';
import 'package:ride_sharing_app/widgets.dart';

class User {
  final String name;
  final String phoneNo;
  final int age;

  User({required this.name, required this.phoneNo, required this.age});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNo,
      'age': age,
    };
  }
}

class UserFormPage extends StatefulWidget {
  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  void saveUserData(User user) async {
    try {
      await usersCollection.add(user.toJson());
      print('User data saved successfully!');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
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
                  ],
                ),
              ),
              SizedBox(height: 45.0),
              SizedBox(
                height: 45,
                width: 350,
                child: ElevatedButton(
                    onPressed: () {
                      nextScreen(context, PassengerHomeScreen());
                    },
                    child: Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveUser(account) async {
    FirebaseFirestore.instance.collection("users").doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
    print("....saved user data...");
  }
}
