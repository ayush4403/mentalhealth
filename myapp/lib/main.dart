import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Registration/signin.dart';
import 'package:myapp/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/Question/quiz.dart'; // Import your quiz screen

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 111, 186),
  ),
  textTheme: GoogleFonts.montserratTextTheme(), // add 500
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
  bool hasCompletedQuiz = prefs.getBool('hasCompletedQuiz') ?? false;

  // Check if the user is logged in
  if (isUserLoggedIn) {
    if (hasCompletedQuiz) {
      runApp(const MyApp());
    } else {
      // Navigate to the quiz screen if the user hasn't completed the quiz
      runApp(   const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QuizScreen(),
      ),);
    }
  } else {
    // Navigate to the sign-in screen if the user is not logged in
    runApp(   const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    ),);
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}