import 'package:flutter/material.dart';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'kindness_challenges.dart';

TextEditingController kindnessController = TextEditingController();

class KindnessPageClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kindness Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KindnessPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KindnessPage extends StatefulWidget {
  @override
  _KindnessPageState createState() => _KindnessPageState();
}

class _KindnessPageState extends State<KindnessPage> {
  String todayChallenge = '';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Select a random challenge for today
    todayChallenge =
        kindnessChallenges[Random().nextInt(kindnessChallenges.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.83,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Kindness Challenge',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                KindnessChallengeCard(
                  challenge: todayChallenge,
                ),
                SizedBox(height: 35),
                Text(
                  'Tell us about your kind act:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.16,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: kindnessController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Write about your kind act.',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await _pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent
                                .withOpacity(0.50), // Background color
                            foregroundColor:
                                Colors.black, // Text and icon color
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_rounded,
                                  color: Colors.white), // Icon color
                              SizedBox(width: 8),
                              Text('Upload Picture(Optional)',
                                  style: TextStyle(
                                      color: Colors.white)), // Text color
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: _selectedImage != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white, // Add background color
                                  ),
                                  child: Image.file(
                                    _selectedImage!,
                                    height: 130,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                        const SizedBox(height: 25.0),
                        Center(
                          child: Container(
                            width: 250,
                            height: 60,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Activity Done',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // If the user picked an image, update the state
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}

class KindnessChallengeCard extends StatelessWidget {
  final String challenge;

  const KindnessChallengeCard({Key? key, required this.challenge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.70), // Add background color
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Challenge:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              challenge,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
