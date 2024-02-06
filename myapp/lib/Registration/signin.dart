import 'package:myapp/home.dart';
import 'package:myapp/Question/quiz.dart';
import 'resetpassword.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../reusable_widgets/reusable_widgets.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import '../../utils/color_utils.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  //String _userName = "";
  //String _userEmail = "";

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

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(),
        ),
      );
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