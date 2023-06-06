import 'package:flutter/material.dart';
import 'package:ride_sharing_app/Pages/Driver_View/DriverData.dart';
import 'package:ride_sharing_app/Pages/Passenger_View/Passenger_requrd.dart';
import 'package:ride_sharing_app/widgets.dart';

class UserStatusScreen extends StatefulWidget {
  static const String route = 'custom_crs';

  const UserStatusScreen({Key? key}) : super(key: key);

  @override
  _UserStatusScreenState createState() => _UserStatusScreenState();
}

class _UserStatusScreenState extends State<UserStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.49,
                child: Image.asset("Assets/Images/driverPassenger.png"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.51),
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                // height: 400,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 71, 242, 248),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Are you a Passenger or \n a Driver",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        height: 45,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              nextScreen(context, UserFormPage());
                            },
                            child: Text("Passenger")),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {
                              nextScreen(context, DriverInfo());
                            },
                            child: Text("Driver Account")),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   left: 10,
              //   child: IconButton(
              //     icon: Icon(Icons.arrow_back_ios),
              //     onPressed: () {
              //       goBackScreen(context);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
