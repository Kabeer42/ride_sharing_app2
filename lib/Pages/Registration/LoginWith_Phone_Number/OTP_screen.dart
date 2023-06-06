import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ride_sharing_app/Pages/App_Screens/Driver_or_passenger.dart';
import 'package:ride_sharing_app/Pages/allowLocation.dart';
import '../../../widgets.dart';
import '../../Passenger_View/PassengerHomeScreen.dart';

class OTP_Screen extends StatefulWidget {
  var number;
  OTP_Screen(this.number);

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String _verificationId = "";

  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(67, 84, 100, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(91, 91, 92, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 50),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  textAlign: TextAlign.center,
                  "We send you a code",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
              ),
              Text("On this Phone : ${widget.number}"),
              const SizedBox(
                height: 30.0,
              ),
              Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {
                  // return s == _verificationId ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                child: ElevatedButton(
                  child: const Text(
                    "Get Verified",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Otp_verification(context);
                    // nextScreen(context, UserLocationScreen());
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                textAlign: TextAlign.center,
                "By Tapping \"Get Started\" you agree to Trems and Conditions and Privacy Policy.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Otp_verification(context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otpController.text,
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user = result.user;
    if (user != null) {
      nextScreenReplace(context, UserStatusScreen());
    } else {
      print('Error');
    }
  }
}
