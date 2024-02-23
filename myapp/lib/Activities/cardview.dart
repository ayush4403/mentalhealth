import 'package:MindFulMe/Activities/Journal/journal.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:MindFulMe/Activities/Gratitude/VideoApp.dart';
import 'package:MindFulMe/Activities/Mental_Marathon/GetStarted.dart';
import 'package:MindFulMe/Activities/Morning_Meditation/mindfulmeditation.dart';
import 'package:MindFulMe/Activities/Music/stressfirstscreen.dart';
import 'package:MindFulMe/Activities/Night_Music/nightmusic.dart';
import 'package:MindFulMe/Activities/Sherlock%20Holmes/LetsPlay.dart';
import 'package:MindFulMe/Activities/Study_Music/studymusic.dart';
import 'package:MindFulMe/Activities/kindness/KindnessPage.dart';
import 'package:MindFulMe/Activities/quotes/daily_quotes.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        appBar: AppBar(
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
    'Gratitude',
    'Mental Marathon',
    'Sherlock Holmes',
    'Daily Thoughts',
    'Study Music',
    'Kindness Challenge',
    'Affirmation',
    'Music',
    'Journal',
  ];

  final List<String> activityImages = [
    'assets/GIF/Card_view/1_morning_meditation.json',
    'assets/GIF/Card_view/2_night_music.json',
    'assets/GIF/Card_view/3_gratitude.json',
    'assets/GIF/Card_view/4_mental_marathon.json',
    'assets/GIF/Card_view/5_sherlock.json',
    'assets/GIF/Card_view/6_thoughts.json',
    'assets/GIF/Card_view/7_study_music.json',
    'assets/GIF/Card_view/8_kindness.json',
    'assets/GIF/Card_view/9_upcoming_events.json',
    'assets/GIF/Card_view/10_music.json',
    'assets/GIF/Card_view/11_affirmation.json',
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
    'Relieve tension and stress with calming melodies and rhythms.',
  ];

  final List<String> cardDescription = [
    "The Morning Meditation module aims to support users in cultivating a positive mindset and setting a harmonious tone for their day ahead. By incorporating guided meditation, visualization, and brainwave beats, users can engage in a holistic meditation experience that contributes to their overall mental well-being.",
    "The Night Music module is thoughtfully curated to provide users with a serene and calming auditory experience, specifically designed to aid in relaxation and promote a peaceful transition into sleep.By offering a harmonious blend of calming tunes, the Night Music module seeks to support users in achieving a restful night's sleep and waking up feeling refreshed and revitalized. Users can explore the diverse soundscape provided by Night Music to find the perfect accompaniment for their nightly rest.",
    "The Gratitude module is a daily companion designed to foster a positive and thankful mindset. Centered around the practice of gratitude, this module provides users with a daily dose of inspiration through carefully curated gratitude quotes. Additionally, users are encouraged to actively participate in the practice by expressing their own feelings of gratitude.",
    "The Mental Marathon module is an exciting and educational journey that empowers users to challenge themselves, learn from diverse subjects, and celebrate their cognitive achievements. It serves as a valuable tool for continuous mental exercise and personal growth.",
    "The Sherlock Holmes module introduces a captivating and interactive image-based question experience, where users can channel their inner detective. Inspired by the renowned detective Sherlock Holmes, this module challenges users to observe, analyze, and deduce based on a given image.",
    "The Daily Thoughts module offers users a dedicated space to record their thoughts, feelings, and experiences on a daily basis. Through this feature, users can note down their reflections, emotions, and significant events, providing a valuable outlet for self-expression and introspection. The interface may include customizable prompts or questions to guide users in their journaling practice, encouraging deeper self-awareness and insight.",
    "The Study Music module provides users with a curated selection of instrumental music tracks specifically designed to enhance concentration, focus, and productivity during study or work sessions. These tracks are carefully chosen to feature calming melodies, rhythmic patterns, and ambient sounds that can help drown out distractions and create an optimal environment for cognitive engagement. Users can easily play, pause, skip tracks, and adjust volume levels within the app interface to customize their study music experience according to their preferences.",
    "The Kindness Challenge module encourages users to engage in acts of kindness towards themselves and others as a way to promote positivity, compassion, and well-being. Users are presented with a series of daily or weekly challenges designed to inspire acts of kindness, generosity, and empathy. Users can track their progress, share their experiences with the community, and receive encouragement and support from fellow participants within the app.",
    "Stay organized and informed about mental health-related events and activities.",
    "The Music module offers users a selection of three types of music specifically curated to promote relaxation, focus, and stress reduction.",
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
    Color.fromARGB(255, 205, 244, 10)!,
  ];

  ActivityList({super.key});

  void handleInfoButtonTap(BuildContext context, String cardDescripation,
      int colorIndex, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColors[colorIndex],
          title: Text(
            'Description',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Text(
            cardDescription[index],
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.normal,
                ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void handleActivityTap(String activity) {
    // Handle the onPressed action for each activity here
    // ignore: avoid_print
    print('Tapped on: $activity');
  }

  void handleStartButtonTap(BuildContext context, String activity) {
    // Handle the onPressed action for the "Start" button here
    // ignore: avoid_print
    print('Started: $activity');

    if (activity == 'Daily Thoughts') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DailyQuotesScreen()),
      );
    }
    if (activity == 'Morning Meditation') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MorningMeditation()),
      );
    }
    if (activity == 'Music') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MusicList()),
      );
    }
    if (activity == 'Study Music') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudyMusicScreen()),
      );
    }
    if (activity == 'Night Music') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NightMusicScreen()),
      );
    }
    if (activity == 'Mental Marathon') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedPage()),
      );
    }
    if (activity == 'Gratitude') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VideoApp()),
      );
    }
    if (activity == 'Kindness Challenge') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KindnessPageClass()),
      );
    }
    if (activity == 'Sherlock Holmes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LetsPlay()),
      );
    }
    if (activity == 'Journal') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JournalScreen()),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          const Spacer(),
                          Text(
                            activities[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Spacer(), // Added
                          IconButton(
                            color: Colors.black38,
                            iconSize: 17,
                            icon: const Icon(Icons.info_outline),
                            onPressed: () => handleInfoButtonTap(
                              context,
                              cardDescription[index],
                              index % cardColors.length,
                              index,
                            ),
                          ),
                        ],
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
                          width: 200,
                          height: 40,
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
