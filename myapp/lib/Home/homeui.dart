import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePageUI extends StatelessWidget {
  const HomePageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.bgColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Pratham!",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
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
                          child: Lottie.asset(
                            'assets/GIF/Gamification/coin.json',
                            
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1001),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: Lottie.asset(
                                  'assets/GIF/Gamification/coin.json',
                                  height: 45,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text("Mood Tracker"),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "View Details",
                                style: TextStyle(
                                  color: AppColors.whiteColor.withOpacity(.8),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.accessibility_sharp,
                                color: AppColors.whiteColor.withOpacity(.8),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "How are you today?",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MoodMoji(emoji: '😣', title: 'Depressed'),
                        MoodMoji(emoji: '😢', title: 'Sad'),
                        MoodMoji(emoji: '😑', title: 'Neutral'),
                        MoodMoji(emoji: '😀', title: 'Happy'),
                        MoodMoji(emoji: '🤩', title: 'Overjoy'),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Metrics",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Row(
                      children: [
                        Text("View Detail"),
                        SizedBox(width: 4),
                        Icon(Icons.ad_units_outlined)
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodMoji extends StatelessWidget {
  const MoodMoji({
    super.key,
    required this.emoji,
    required this.title,
  });
  final String emoji;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            emoji,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
