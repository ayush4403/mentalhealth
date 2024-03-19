// ignore_for_file: file_names
import 'dart:async';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TratakaActivity extends StatefulWidget {
  const TratakaActivity({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TratakaActivityState createState() => _TratakaActivityState();
}

class _TratakaActivityState extends State<TratakaActivity> {
  double progressValue = 1.0;
  int totalTimeInSeconds = 30; // 5 minutes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (totalTimeInSeconds == 0) {
          timer.cancel();
        } else {
          setState(() {
            totalTimeInSeconds--;
            progressValue = totalTimeInSeconds / 30;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const CardView());
          },
        ),
        title: const Text(
          'Tratak',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/Images/Tratak/Tratak.json',
                width: 400,
                height: 400,
              ),
              const Spacer(),
              LinearProgressIndicator(
                value: progressValue,
                minHeight: 10,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                backgroundColor: Colors.grey[300]!,
              ),
              const SizedBox(height: 60),
              if (progressValue == 0)
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      _openAnimatedDialog(context); // Show the dialog
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CardView()));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Activity Done',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(a1),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        color: Colors.red, // Upper part background color
                      ),
                      SizedBox(
                        height:
                            2, // Adjust the thickness of the horizontal line
                        child: Container(
                          color: Colors.grey, // Color of the horizontal line
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Great Job!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'You have successfully completed today\'s activity. You have earned 50 coins for it. Come back tomorrow for more.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog box
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .blue, // Change button color if needed
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40, // Adjust positioning as needed
                    left: MediaQuery.of(context).size.width / 2 - 125,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Circular background color
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2, // Adjust the border width as needed
                        ),
                      ),
                      child: Lottie.asset(
                        'assets/GIF/ShowDialog/trophy.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
