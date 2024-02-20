import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../reusable_widgets/reusable_widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
    // ignore: unused_local_variable
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
        // Update user's display name
        await user.updateDisplayName(userName);

        // Send email verification
        await user.sendEmailVerification();

        // Create a document in Firestore Users collection
        final userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(user.uid);
        await userDocRef.set({'email': userEmail, 'flag': false});

        _showSnackBar(
            "A verification email has been sent to your inbox. Please verify your email.");
        _userNameTextController.clear();
        _emailTextController.clear();
        _passwordTextController.clear();
        _confirmPasswordTextController.clear();
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isUserLoggedIn', true);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Error: $error");
      }
      if (kDebugMode) {
        print("Stack Trace: $stackTrace");
      }
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Lottie.asset(
              'assets/GIF/Registration/signup.json',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.34,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.66,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 111, 186),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.width * 0.001, 20, 0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "SignUp",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
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
                    const SizedBox(
                      height: 10,
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
