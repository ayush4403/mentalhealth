import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MindFulMe/Startup/Question/quiz.dart';
import 'package:MindFulMe/Startup/home.dart';
import 'resetpassword.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../reusable_widgets/reusable_widgets.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  int indexday = 1;
  int indexweek = 1;
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(days: 1),
      (timer) {
        // Get the current time
        DateTime now = DateTime.now();
        // Check if it's midnight
        if (now.hour == 0 && now.minute == 0 && now.second == 0) {
          // Increment day
          setState(
            () {
              indexday++;
              if (indexday > 7) {
                indexday = 1;
                indexweek++;
                // Fetch data for new week
              }
            },
          );
        }
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      // Check if email and password are not empty
      if (_emailTextController.text.isEmpty ||
          _passwordTextController.text.isEmpty) {
        _showSnackBar('Please enter both email and password.');
        return;
      }

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Check flag from Firestore
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .get();

        if (snapshot.exists) {
          final bool flag = snapshot.data()?['flag'] ?? false;
          if (flag) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const QuizScreen(),
              ),
            );
          }
        }
      }
    } catch (e) {
      String errorMessage = 'An error occurred during sign-in.';

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = 'Incorrect email or password';
        }
      }

      _showSnackBar(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            children: <Widget>[
              Lottie.asset(
                'assets/GIF/Registration/signin.json',
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.width * 0.1, 20, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Welcome to MindfulMe',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        reusableTextField(
                            "Enter Email",
                            Icons.person_outline,
                            false,
                            _emailTextController,
                            TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                            "Enter Password",
                            Icons.lock_outline,
                            true,
                            _passwordTextController,
                            TextInputType.visiblePassword),
                        const SizedBox(
                          height: 5,
                        ),
                        firebaseUIButton(context, "Sign In", _handleSignIn),
                        signUpOption(),
                        forgotPasswordOption(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white70,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Row forgotPasswordOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPassword(),
              ),
            );
          },
          child: const Text(
            " Forgot Password?",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
