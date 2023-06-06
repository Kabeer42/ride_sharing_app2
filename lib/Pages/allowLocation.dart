import 'package:flutter/material.dart';
import 'package:ride_sharing_app/Pages/App_Screens/Driver_or_passenger.dart';
import 'package:ride_sharing_app/widgets.dart';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

late LatLng currentLocation;

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({Key? key}) : super(key: key);

  @override
  _UserLocationScreenState createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  bool allowLocation = false;
  // late LatLng currentLocation;
  Location location = new Location();
  List<LatLng> polylineCoordinates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 45, left: 8, right: 8),
                height: MediaQuery.of(context).size.height * 0.55,
                child: Image.asset("Assets/Images/ShowLocation.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Allow app to access \n your Location",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.5, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  "This is necessary so that the nearest drivers can receive the request",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 45,
                width: 350,
                child: ElevatedButton(
                    onPressed: () {
                      location.onLocationChanged.listen((locationData) {
                        setState(() {
                          currentLocation = LatLng(
                              locationData.latitude!, locationData.longitude!);
                          polylineCoordinates.add(currentLocation);
                          allowLocation = true;
                        });
                      });
                      allowLocation
                          ? null
                          : nextScreen(context, UserStatusScreen());
                    },
                    child: Text("Enable Location Services")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
