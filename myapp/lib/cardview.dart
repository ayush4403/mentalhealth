import 'package:flutter/material.dart';
<<<<<<< HEAD
<<<<<<< HEAD
=======
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38

void main() {
  runApp(CardView());
}
=======
import 'package:lottie/lottie.dart';
>>>>>>> dc10104511bcfe26bf2b70942f182a1ea1848657

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    
=======
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
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

<<<<<<< HEAD
=======
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

  final List<String> descripation = [
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

>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    // ignore: avoid_print
    print('Tapped on: $activity');
  }

<<<<<<< HEAD
=======
  void handleStartButtonTap(String activity) {
    // Handle the onPressed action for the "Start" button here
    // ignore: avoid_print
    print('Started: $activity');
  }

>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
<<<<<<< HEAD
        return GestureDetector(
          onTap: () => handleActivityTap(activities[index]),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.blue[100], // Background color for the activity
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Text(
=======
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100], // Background color for the activity
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
<<<<<<< HEAD
                  child: Text(
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
                    activities[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(
                    width: 80,
                    height: 35, // Adjust the width and height as needed for the "Start" button
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the onPressed action for the "Start" button here
                        print('Started: ${activities[index]}');
                      },
                      child: Text('Start', style: TextStyle(fontSize: 12)), // Adjust the font size
                    ),
                  ),
                ],
              ),
=======
                ),
                SizedBox(
                  width: 80, // Adjust the width as needed for the "Start" button
                  child: ElevatedButton(
                    onPressed: () => handleStartButtonTap(activities[index]),
                    child: Text('Start', style: TextStyle(fontSize: 12)), // Adjust the font size
=======
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
                        descripation[index],
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
                            onPressed: () =>
                                handleStartButtonTap(activities[index]),
                            child: const Text(
                              'Start',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
>>>>>>> dc10104511bcfe26bf2b70942f182a1ea1848657
                  ),
                ),
              ],
>>>>>>> f901e93769d25b890e4545ee2292bdc8d69faa38
            ),
          ),
        );
      },
    );
  }
}
