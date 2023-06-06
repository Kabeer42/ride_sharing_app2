import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing_app/Pages/Passenger_View/PassengerHomeScreen.dart';

import '../../../widgets.dart';
import 'OTP_screen.dart';

class PhoneRegistration extends StatefulWidget {
  const PhoneRegistration({super.key});

  @override
  State<PhoneRegistration> createState() => _PhoneRegistrationState();
}

class _PhoneRegistrationState extends State<PhoneRegistration> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _CCodeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId = "";
  late var phone;
  @override
  void initState() {
    super.initState();
    _CCodeController.text = '+92';
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 50),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Enter your phone number to sign in ",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _CCodeController,
                            style: const TextStyle(fontSize: 19),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 35, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            style: const TextStyle(fontSize: 19),
                            decoration: const InputDecoration(
                              hintText: 'Enter Phone Number',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    "GET STARTED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // PhoneVerification();
                    _sendVerificationCode();
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

  void PhoneVerification() async {
    phone = _CCodeController.text + _phoneController.text;
    print('${phone}');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Sign in with the OTP code.
        FirebaseAuth.instance.signInWithCredential(credential);
        nextScreen(context, OTP_Screen(phone));
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification errors.
        nextScreen(context, PassengerHomeScreen());
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and resend token.
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resend the verification code.
      },
    );
  }

  Future<void> _sendVerificationCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
