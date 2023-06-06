import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../allowLocation.dart';

class PassengerHomeScreen extends StatefulWidget {
  static const String route = 'custom_crs';
  const PassengerHomeScreen({Key? key}) : super(key: key);

  @override
  _PassengerHomeScreenState createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  // late LatLng currentLocation;
  Widget circle = Stack(
    alignment: AlignmentDirectional.center,
    children: [
      Icon(
        Icons.circle,
        size: 20,
        color: Colors.orange,
      ),
      Icon(
        Icons.circle,
        size: 12,
        color: Color.fromARGB(255, 71, 242, 248),
      ),
    ],
  );
  @override
  void initState() {
    super.initState();
    location.onLocationChanged.listen((locationData) {
      setState(() {
        currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        polylineCoordinates.add(currentLocation);
      });
    });
  }

  Location location = Location();
  late var _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  List<LatLng> polylineCoordinates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              FlutterMap(
                mapController: MapController(),
                options: MapOptions(
                  center: currentLocation,
                  zoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .43),
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                // height: 400,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 71, 242, 248),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(8),
                            child: Column(children: [
                              Container(
                                height: 70,
                                width: 90,
                                child: Image.asset('Assets/Images/Auto.png'),
                              ),
                              Text("Auto Ride")
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Container(
                                height: 70,
                                width: 90,
                                child: Image.asset('Assets/Images/Auto.png'),
                              ),
                              Text("Auto Ride")
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(8),
                            child: Column(children: [
                              Container(
                                height: 70,
                                width: 90,
                                child: Image.asset("Assets/Images/Auto.png"),
                              ),
                              Text("Auto Ride")
                            ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          circle,
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(hintText: "From"),
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          circle,
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(hintText: "To"),
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Rs",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Offer your fare "),
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message,
                            size: 22,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Options and Comments"),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Find a Driver")),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(left: 350, top: 230, child: ActionButton()),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child: InkWell(
              //     onTap: () {},
              //     child: CircleAvatar(
              //       child: Icon(Icons.more_vert),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget PassengerDrawer() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.5,
        ));
  }

  Widget ActionButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(25)),
        child: Icon(Icons.location_searching, color: Colors.white),
      ),
    );
  }
}
