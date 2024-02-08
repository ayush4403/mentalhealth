import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Activities/Morning_Meditation/mindfulmeditation.dart';
import 'package:myapp/Activities/STRESSBUSTER/stressfirstscreen.dart';
//import 'package:myapp/Activities/quotes/daily_quote.dart';
import 'package:myapp/Activities/quotes/daily_quotes.dart';
//import 'package:myapp/Activities/Stress_Buster/stress_buster.dart';

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Activities',
            style: TextStyle(
              color: Colors.white, // Change text color to white
              fontSize: 20, // Change font size
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        ),
        body: ActivityList(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ActivityList extends StatelessWidget {
  final List<String> activities = [
    'Morning Meditation',
    'Night Music',
    'Brain Training Games',
    'Mental Marathon',
    'Image Based Riddles',
    'Motivation Quotes',
    'Study Music',
    'Memory Technique',
    'Upcoming Events',
    'Stress Buster Music',
  ];

  final List<String> activityImages = [
    'assets/GIF/Card_view/1_morning_meditation.json',
    'assets/GIF/Card_view/2_night_music.json',
    'assets/GIF/Card_view/3_brain_training_games.json',
    'assets/GIF/Card_view/4_mental_marathon.json',
    'assets/GIF/Card_view/5_img_rdd.json',
    'assets/GIF/Card_view/6_motivation quotes.json',
    'assets/GIF/Card_view/7_study_music.json',
    'assets/GIF/Card_view/8_memory_technique.json',
    'assets/GIF/Card_view/9_upcoming_events.json',
    'assets/GIF/Card_view/10_stress_buster_music.json',
  ];

  final List<String> description = [
    'Start your day with calmness and focus through guided meditation.',
    'Wind down and relax with soothing melodies before bedtime.',
    'Sharpen your cognitive skills and keep your mind active with engaging challenges.',
    'Dive into a variety of mental exercises to boost your mental stamina and agility.',
    'Exercise your problem-solving abilities with visually stimulating puzzles.',
    'Find inspiration and encouragement to keep pushing forward through uplifting quotes.',
    'Enhance your concentration and productivity with background music optimized for studying.',
    'Learn effective techniques to improve your memory and retention.',
    'Stay organized and informed about mental health-related events and activities.',
    'Relieve tension and stress with calming melodies and rhythms.',
  ];

  final List<Color> cardColors = [
    Colors.blue[100]!,
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.teal[100]!,
    Colors.indigo[100]!,
    Colors.amber[100]!,
    Colors.deepOrange[100]!,
  ];

  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    // ignore: avoid_print
    print('Tapped on: $activity');
  }

  void handleStartButtonTap(BuildContext context, String activity) {
    // Handle the onPressed action for the "Start" button here
    // ignore: avoid_print
    print('Started: $activity');

    if (activity == 'Motivation Quotes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyQuotesScreen()),
      );
    }
    if (activity == 'Morning Meditation') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MorningMeditation()),
      );
    }
    if (activity == 'Stress Buster Music') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicList()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColors[index], // Assign color based on index
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset(
                  activityImages[index],
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        activities[index],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        description[index],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.normal,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: 200, // Specify the desired width
                          height: 40, // Specify the desired height
                          child: ElevatedButton(
                            onPressed: () => handleStartButtonTap(
                                context, activities[index]),
                            child: const Text(
                              'Start',
                              style: TextStyle(fontSize: 15),
                            ),
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
      },
    );
  }
}
