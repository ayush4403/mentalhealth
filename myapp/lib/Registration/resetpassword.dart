import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Registration/signin.dart';
import '../../reusable_widgets/reusable_widgets.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  bool _isSent = false;

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Password Link Sent'),
          content:
              const Text('A reset password link has been sent to your inbox.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showEmailNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email Not Found'),
          content: const Text(
              'The email address is not registered. Please check your email or register.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Lottie.asset(
              'assets/GIF/password.json',
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
                          "Reset Password",
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
                        height: 20,
                      ),
                      reusableTextField("Enter Email Id", Icons.person_outline,
                          false, _emailTextController, TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      firebaseUIButton(context, "Reset Password", () {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: _emailTextController.text)
                            .then((value) {
                          setState(() {
                            _isSent = true;
                          });
                          _showResetPasswordDialog();
                        }).catchError((error) {
                          // Handle errors, e.g., email not found
                          print("Error sending reset email: $error");
                          if (error is FirebaseAuthException) {
                            if (error.code == 'user-not-found') {
                              // Handle email not found
                              _showEmailNotFoundDialog();
                            } else {
                              // Handle other Firebase Authentication errors
                              print("Error sending reset email: ${error.code}");
                            }
                          }
                        });
                      })
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
