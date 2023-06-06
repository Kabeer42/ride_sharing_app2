import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing_app/widgets.dart';
import 'Pages/Registration/Test/pickImagefromGallery.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      home: ProfilePicture(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const SplashScreen(), // Route for the splash screen
      //   '/home': (context) =>
      //       const PhoneRegistration(), // Route for the home screen
      // },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next screen after the delay
      // nextScreen(context, PhoneRegistration());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Customize your splash screen UI here
      body: Center(child: Image.asset("Assets/Images/GoRideLogo.png")),
    );
  }
}

class ScreenState extends StatelessWidget {
  const ScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Customize your splash screen UI here
      body: Center(child: Image.asset("Assets/Images/GoRideLogo.png")),
    );
  }
}

class LoginOptionScreen extends StatefulWidget {
  @override
  State<LoginOptionScreen> createState() => _LoginOptionScreenState();
}

class _LoginOptionScreenState extends State<LoginOptionScreen> {
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign in",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  height: 52,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.orange)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email", border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 52,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.orange)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 261,
                        child: TextFormField(
                          obscureText: secure ? true : false,
                          decoration: InputDecoration(
                              hintText: "Password", border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        // width: 50,
                        child: IconButton(
                          icon: secure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              if (secure == true) {
                                secure = false;
                              } else {
                                secure = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("Forgot password?")),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 155,
                      child: Divider(
                        thickness: 2.5,
                        color: Colors.orange,
                      ),
                    ),
                    Text("Or"),
                    SizedBox(
                      width: 155,
                      child: Divider(
                        thickness: 2.5,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in Phone",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w600),
                    ),
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
