import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen( {super.key} );

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _registerUser() async {
    final String userName = _userNameTextController.text.trim();
    final String userEmail = _emailTextController.text.trim();
    final String password = _passwordTextController.text;
    final String confirmPassword = _confirmPasswordTextController.text;

    if (!_validateFields()) {
      return;
    }

    try {

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);

        // Send email verification
        await user.sendEmailVerification();

        _showSnackBar(
            "A verification email has been sent to your inbox. Please verify your email.");
        _userNameTextController.clear();
        _emailTextController.clear();
        _passwordTextController.clear();
        _confirmPasswordTextController.clear();
      }
    } catch (error, stackTrace) {
      print("Error: $error");
      print("Stack Trace: $stackTrace");
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          _showSnackBar(
              "Email already exists. Please sign in or use a different email.");
        } else {
          _showSnackBar("Error: ${error.message}");
        }
      } else {
        _showSnackBar("An error occurred. Please try again later.");
      }
    }
  }

  bool _validateFields() {
    final String userName = _userNameTextController.text.trim();
    final String userEmail = _emailTextController.text.trim();
    final String password = _passwordTextController.text;
    final String confirmPassword = _confirmPasswordTextController.text;

    if (userName.isEmpty ||
        userEmail.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return false;
    }

    if (!isValidEmail(userEmail)) {
      _showSnackBar("Please enter a valid email address.");
      return false;
    }

    if (password.length < 6) {
      _showSnackBar("Password should be at least 6 characters.");
      return false;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match.");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Lottie.asset(
                'assets/signup.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.34,
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.66,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 42, 164, 225),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.width*0.001, 20, 0),
                child: ListView(
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter UserName",
                      Icons.person_outline,
                      false,
                      _userNameTextController,
                      TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter Email Id",
                      Icons.person_outline,
                      false,
                      _emailTextController,
                      TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter Password",
                      Icons.lock_outlined,
                      true,
                      _passwordTextController,
                      TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Confirm Password",
                      Icons.lock_outlined,
                      true,
                      _confirmPasswordTextController,
                      TextInputType.visiblePassword,
                    ),
                    firebaseUIButton(context, "Sign Up", _registerUser),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
