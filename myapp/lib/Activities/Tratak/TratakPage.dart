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
                'assets/GIF/Tratak/Tratak.json',
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
}
