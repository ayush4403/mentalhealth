import 'package:MindFulMe/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
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
