import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isSubmitting = false;
  bool _isEmailSent = false;
  late String _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendEmailVerification() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      setState(() {
        _isEmailSent = true;
        _isSubmitting = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSubmitting = false;
        _emailError = e.message!;
      });
    }
  }

  void _verifyEmail() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
          email: _emailController.text, password: _codeController.text);
      await user?.linkWithCredential(credential);
      setState(() {
        _isSubmitting = false;
      });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSubmitting = false;
        _emailError = e.message!;
      });
    }
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        if (_isEmailSent)
          Text('A verification email has been sent to your email address.'),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            if (_emailError != null) {
              return _emailError;
            }
            return null;
          },
        ),
        TextFormField(
          controller: _codeController,
          decoration: InputDecoration(labelText: 'Verification code'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter the verification code';
            }
            if (_emailError != null) {
              return _emailError;
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: _isSubmitting
              ? CircularProgressIndicator()
              : Text('Verify email'),
          onPressed: _isSubmitting ? null : _verifyEmail,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Email verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: _buildEmailForm(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isSubmitting ? CircularProgressIndicator() : Icon(Icons.email),
        onPressed: _isSubmitting ? null : _sendEmailVerification,
      ),
    );
  }
}
