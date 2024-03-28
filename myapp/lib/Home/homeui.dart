import 'package:MindFulMe/Activities/Gratitude/VideoApp.dart';
import 'package:MindFulMe/Activities/Journal/journal.dart';
import 'package:MindFulMe/Activities/Morning_Meditation/morningmeds.dart';
import 'package:MindFulMe/Activities/kindness/KindnessPage.dart';
import 'package:MindFulMe/Activities/quotes/daily_quotes.dart';
import 'package:MindFulMe/Home/balls_widget.dart';
import 'package:MindFulMe/Home/recommendation_model.dart';
import 'package:MindFulMe/Home/recommendations.dart';
import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset('assets/Images/Home/model.jpeg'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Hello, Sara!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.bgColor,
                        ),
                      ),
                      Text(
                        "Have a good day",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 28),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(1001),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Image.asset(
                            'assets/Images/Gamification/coin.png',
                            height: 55,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "603 Points",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  ),
                  Positioned(
                    height: 220,
                    right: -100,
                    bottom: -30,
                    child: Lottie.asset('assets/GIF/Home/events.json'),
                  ),
                  Positioned.fill(
                    top: 35,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ready to perform\n today's activities?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Upcoming Events",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 140,
                          child: FilledButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MorningMeds()),
                              );
                            },
                            child: const Text("VIEW"),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommended for you",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View all",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: RecommendationsData.all.length,
                itemBuilder: (context, index) {
                  RecommendationModel model = RecommendationsData.all[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Balls(model: model),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade300,
                      border: Border.all(
                        color: Colors.indigo.shade300,
                      ),
                    ),
                  ),
                  Positioned(
                    height: 220,
                    right: -100,
                    bottom: -30,
                    child: Lottie.asset('assets/GIF/Home/yoga.json'),
                  ),
                  Positioned.fill(
                    top: 35,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ready to start\nyour first session?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Meditation 5-10 min",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 140,
                          child: FilledButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MorningMeds()),
                              );
                            },
                            child: const Text("START"),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 3.0),
                  child: buildGridViewCard(
                    context,
                    "Thought of the Day",
                    "If you love life, Don't waste time, For time is what life is made up of.",
                    Image.asset(
                      'assets/Icons/Home/thought.png',
                      height: 30,
                      width: 30,
                    ),
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DailyQuotesScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 3.0),
                  child: buildGridViewCard(
                    context,
                    "Today's Challenge",
                    "Send Thank you email to someone who has helped you.",
                    Image.asset(
                      'assets/Icons/Home/quest.png',
                      height: 30,
                      width: 30,
                    ),
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const KindnessPageClass(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 3.0),
                  child: buildGridViewCard(
                    context,
                    "Feel Gratitude",
                    "I feel gateful to life.",
                    Image.asset(
                      'assets/Icons/Home/gratitude.png',
                      height: 30,
                      width: 30,
                    ),
                    Colors.green,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VideoApp(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 3.0),
                  child: buildGridViewCard(
                    context,
                    "Write Journal",
                    "I win 3 clash royale matches today out of 3.",
                    Image.asset(
                      'assets/Icons/Home/journal.png',
                      height: 30,
                      width: 30,
                    ),
                    Colors.pink,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const JournalScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridViewCard(
    BuildContext context,
    String title,
    String text,
    Widget icon,
    Color color,
    Null Function() param5,
  ) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: color),
            ),
          ),
          Positioned.fill(
            top: 12,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 15, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MorningMeds(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(child: icon),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
