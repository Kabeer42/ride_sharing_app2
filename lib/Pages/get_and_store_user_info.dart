import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Users {
  String name;
  String email;
  String phone;

  Users(this.name, this.email, this.phone);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void _addUser() {
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    Users user = Users(name, email, phone);

    _databaseReference.child('users').child('user_id').set(user.toJson());

    setState(() {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
