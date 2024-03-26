import 'package:MindFulMe/Activities/Morning_Meditation/morningmeds.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset('assets/Images/model.jpeg')),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning, Sara!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "have a good day",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.indigo.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(1001),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
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
                          color: AppColors.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                        color: Colors.indigo.shade300,
                        border: Border.all(color: Colors.indigo.shade300)),
                  ),
                  Positioned(
                    height: 220,
                    right: -80,
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
                              child: const Text("START")),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                  child: const Text("View all"),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
            )
          ],
        ),
      ),
    );
  }
}
