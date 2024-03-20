import 'package:MindFulMe/Profile/pro_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: <Widget>[
                  Lottie.asset(
                    'assets/GIF/Profile/profile.json',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Manan Goradiya',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Gujarat, India',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.edit_rounded),
                                  iconSize: 30,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildCombinedRoundedBox('15', 'Streak'),
                                buildCombinedRoundedBox('100', 'Points'),
                                buildCombinedRoundedBox('21', 'Age'),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildAvtarIcon(FontAwesomeIcons.award),
                                const SizedBox(
                                  width: 12,
                                ),
                                buildAvtarIcon(FontAwesomeIcons.award),
                                const SizedBox(
                                  width: 12,
                                ),
                                buildAvtarIcon(FontAwesomeIcons.award),
                                const SizedBox(
                                  width: 12,
                                ),
                                buildAvtarIcon(FontAwesomeIcons.award),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const Column(
                              children: [
                                ActivityCardRow(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            right: MediaQuery.of(context).size.height * 0.001,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Colors.black54,
              ),
              onPressed: () {
                // Navigate to the profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProSetting(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCombinedRoundedBox(String number, String text) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget buildAvtarIcon(IconData icon) => CircleAvatar(
        radius: 35,
        child: Center(
          child: Icon(
            icon,
            size: 35,
          ),
        ),
      );
}

class ActivityCardRow extends StatelessWidget {
  const ActivityCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ActivityCard(
          image: 'assets/Images/Report/1_morning_meditation.jpg',
          name: 'Morning Meditation',
          progress: 40,
        ),
        ActivityCard(
          image: 'assets/Images/Report/2_mental_marathon.jpg',
          name: 'Mental Marathon',
          progress: 70,
        ),
        ActivityCard(
          image: 'assets/Images/Report/3_shelock_holmes.jpg',
          name: 'Sherlock Holmes',
          progress: 20,
        ),
        ActivityCard(
          image: 'assets/Images/Report/4_night_music.jpg',
          name: 'Night Music',
          progress: 90,
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String image;
  final String name;
  final int progress;

  const ActivityCard({
    super.key,
    required this.image,
    required this.name,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 12.0,
        color: Colors.purple[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: List.generate(
                    7,
                    (dayIndex) {
                      // Replace the condition with your actual logic
                      bool isDayDone = dayIndex % 2 == 0;
                      return Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          color: isDayDone ? Colors.green : Colors.red,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: CircularPercentIndicator(
                    radius: 25,
                    percent: 0.4,
                    lineWidth: 3,
                    backgroundColor: Colors.blueAccent,
                    center: const Text(
                      '40%',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color.fromARGB(255, 239, 16, 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
