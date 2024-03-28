import 'dart:io';
import 'package:MindFulMe/Profile/pro_setting.dart';
import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.bgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: AppColors.bgColor,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProSetting(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: _pickImage,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.34,
                            fit: BoxFit.cover,
                          )
                        : Lottie.asset(
                            'assets/GIF/Profile/profile.json',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.34,
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CerboTech Pvt. Ltd.',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Gujarat, India',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.2),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: IconButton(
                                  icon: const Icon(Icons.edit_rounded),
                                  iconSize: 30,
                                  color: AppColors.primaryColor,
                                  onPressed: _pickImage,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCombinedRoundedBox(
                                ['15', '100', '21'],
                                ['Streak', 'Points', 'Age'],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            height: 20,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ActivityCardRow(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCombinedRoundedBox(List<String> numbers, List<String> labels) {
    return Builder(
      builder: (BuildContext context) {
        double boxWidth = MediaQuery.of(context).size.width * 0.9;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: boxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < numbers.length; i++) ...[
                      Text(
                        numbers[i],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (i < numbers.length - 1) const SizedBox(width: 20),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < labels.length; i++) ...[
                      Text(
                        labels[i],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (i < labels.length - 1) const SizedBox(width: 20),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
        elevation: 14.0,
        color: Colors.cyan[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: List.generate(
                      7,
                      (dayIndex) {
                        // Replace the condition with your actual logic
                        bool isDayDone = dayIndex % 2 == 0;
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: isDayDone
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
