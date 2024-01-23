import 'dart:async';
import 'dart:math';
// ignore: avoid_web_libraries_in_flutter

//import 'package:first/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/get_started.dart';
import 'package:myapp/signin.dart';
import 'package:myapp/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context as BuildContext,
          MaterialPageRoute(builder: (context) => Welcome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color.fromARGB(255, 42, 164, 225),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/newlogo.svg',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                child: const Center(
                    child: Text(
                  'MindfulMe',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
              ),
            ],
          ),
        ));
  }
}
