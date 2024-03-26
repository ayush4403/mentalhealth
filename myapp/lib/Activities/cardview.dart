// ignore_for_file: use_build_context_synchronously
import 'package:MindFulMe/Activities/Affirmation/Affirmation.dart';
import 'package:MindFulMe/Activities/Journal/journal.dart';
import 'package:MindFulMe/Activities/Morning_Meditation/morningmeds.dart';
import 'package:MindFulMe/Activities/Music/music_main.dart';
import 'package:MindFulMe/Activities/Night_Music/night_main.dart';
import 'package:MindFulMe/Activities/Power_nap/power_nap_list.dart';
import 'package:MindFulMe/Activities/Tratak/TratakIntroScreen.dart';
import 'package:MindFulMe/exampleaudio/exampletemplate.dart';
import 'package:MindFulMe/exampleaudio/recommendation_model.dart';
import 'package:MindFulMe/exampleaudio/recommendations.dart';
import 'package:MindFulMe/reusable_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:MindFulMe/Activities/Gratitude/VideoApp.dart';
import 'package:MindFulMe/Activities/Mental_Marathon/GetStarted.dart';
import 'package:MindFulMe/Activities/Sherlock%20Holmes/LetsPlay.dart';
import 'package:MindFulMe/Activities/Study_Music/studymusic.dart';
import 'package:MindFulMe/Activities/kindness/KindnessPage.dart';
import 'package:MindFulMe/Activities/quotes/daily_quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late bool activityCompleted;
  

  @override
  void initState() {
    super.initState();
    activityCompleted = false;
    initializeActivityCompletionStatus();
  }

  Future<void> initializeActivityCompletionStatus() async {
    activityCompleted = await checkActivityCompletionStatus();
    setState(() {});
  }

  Future<bool> checkActivityCompletionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? activityStatus = prefs.getBool('activityCompleted');
    String? completionTimeString = prefs.getString('completionTime');
    DateTime? completionTime;

    if (activityStatus != null && completionTimeString != null) {
      completionTime = DateTime.parse(completionTimeString);
      DateTime todayAtMidnight = DateTime.now().subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second,
          milliseconds: DateTime.now().millisecond,
          microseconds: DateTime.now().microsecond));
      if (completionTime.isBefore(todayAtMidnight)) {
        return false;
      } else {
        Duration difference = DateTime.now().difference(completionTime);
        return difference.inHours < 24;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (activityCompleted == null) {
      return const CircularProgressIndicator(); // Show loading indicator while initializing
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: Text(
            'Activities',
            style: TextStyle(
              color: AppColors.bgColor, // Change text color to white
              fontSize: 20, // Change font size
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: ActivityList(
          checkActivityCompletionStatus: checkActivityCompletionStatus,
          activityCompleted: activityCompleted,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: must_be_immutable
class ActivityList extends StatelessWidget {
  final Function checkActivityCompletionStatus;
  late bool activityCompleted = false;

  ActivityList({
    super.key,
    required this.checkActivityCompletionStatus,
    required this.activityCompleted,
  });

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
    'Tratak',
    'Power nap',
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
    'assets/GIF/Card_view/9_affirmation.json',
    'assets/GIF/Card_view/10_music.json',
    'assets/GIF/Card_view/11_tratak.json',
    'assets/GIF/Card_view/12_power_nap.json',
    'assets/GIF/Card_view/13_journal.json',
  ];

  final List<String> description = [
    'Start your day with calmness and focus through guided meditation.', //1
    'Wind down and relax with soothing melodies before bedtime.', //2
    'Sharpen your cognitive skills and keep your mind active with engaging challenges.', //3
    'Dive into a variety of mental exercises to boost your mental stamina and agility.', //4
    'Exercise your problem-solving abilities with visually stimulating puzzles.', //5
    'Find inspiration and encouragement to keep pushing forward through uplifting quotes.', //6
    'Enhance your concentration and productivity with background music optimized for studying.', //7
    'Learn effective techniques to improve your memory and retention.', //8
    'Elevate your mood and confidence with daily affirmations.', //9
    'Relieve tension and stress with calming melodies and rhythms.', //10
    'Enhance concentration and mental clarity through tratak meditation.', //11
    'Recharge your energy levels and boost productivity with a quick power nap.', //12
    'Capture your thoughts and feelings easily, promoting self-reflection and emotional awareness.', //13
  ];

  final List<String> cardDescription = [
    "The Morning Meditation module aims to support users in cultivating a positive mindset and setting a harmonious tone for their day ahead. By incorporating guided meditation, visualization, and brainwave beats, users can engage in a holistic meditation experience that contributes to their overall mental well-being.", //1
    "The Night Music module is thoughtfully curated to provide users with a serene and calming auditory experience, specifically designed to aid in relaxation and promote a peaceful transition into sleep.By offering a harmonious blend of calming tunes, the Night Music module seeks to support users in achieving a restful night's sleep and waking up feeling refreshed and revitalized. Users can explore the diverse soundscape provided by Night Music to find the perfect accompaniment for their nightly rest.", //2
    "The Gratitude module is a daily companion designed to foster a positive and thankful mindset. Centered around the practice of gratitude, this module provides users with a daily dose of inspiration through carefully curated gratitude quotes. Additionally, users are encouraged to actively participate in the practice by expressing their own feelings of gratitude.", //3
    "The Mental Marathon module is an exciting and educational journey that empowers users to challenge themselves, learn from diverse subjects, and celebrate their cognitive achievements. It serves as a valuable tool for continuous mental exercise and personal growth.", //4
    "The Sherlock Holmes module introduces a captivating and interactive image-based question experience, where users can channel their inner detective. Inspired by the renowned detective Sherlock Holmes, this module challenges users to observe, analyze, and deduce based on a given image.", //5
    "The Daily Thoughts module offers users a dedicated space to record their thoughts, feelings, and experiences on a daily basis. Through this feature, users can note down their reflections, emotions, and significant events, providing a valuable outlet for self-expression and introspection. The interface may include customizable prompts or questions to guide users in their journaling practice, encouraging deeper self-awareness and insight.", //6
    "The Study Music module provides users with a curated selection of instrumental music tracks specifically designed to enhance concentration, focus, and productivity during study or work sessions. These tracks are carefully chosen to feature calming melodies, rhythmic patterns, and ambient sounds that can help drown out distractions and create an optimal environment for cognitive engagement. Users can easily play, pause, skip tracks, and adjust volume levels within the app interface to customize their study music experience according to their preferences.", //7
    "The Kindness Challenge module encourages users to engage in acts of kindness towards themselves and others as a way to promote positivity, compassion, and well-being. Users are presented with a series of daily or weekly challenges designed to inspire acts of kindness, generosity, and empathy. Users can track their progress, share their experiences with the community, and receive encouragement and support from fellow participants within the app.", //8
    "Affirmations are positive statements that can uplift your mood and boost self-esteem. In our app, access a variety of pre-written affirmations or create your own tailored to your goals. By integrating affirmations into your daily routine, you can cultivate a positive mindset, reduce stress, and enhance resilience, ultimately fostering a greater sense of well-being.", //9
    "The Music module offers users a selection of three types of music specifically curated to promote relaxation, focus, and stress reduction.", //10
    "Tratak, a form of meditation, involves focusing your gaze on a single point, such as a candle flame or a symbol, to enhance concentration and clarity of mind. Our app offers guided Tratak sessions to help users improve their focus, reduce distractions, and promote relaxation.", //11
    "Take a quick power nap with our app to rejuvenate your energy levels and enhance productivity. Set your desired nap duration, relax with soothing sounds or music, and wake up feeling refreshed and revitalized. Incorporating power naps into your routine can boost cognitive function, improve mood, and help you stay alert throughout the day.", //12
    "Record your thoughts, feelings, and experiences effortlessly with our journal feature. Whether it's jotting down daily reflections, setting goals, or expressing gratitude, our app provides a safe space for self-expression and self-discovery.", //13
  ];

  final List<Color> cardColors = [
    Colors.blue[100]!, //1
    Colors.red[100]!, //2
    Colors.green[100]!, //3
    Colors.yellow[100]!, //4
    Colors.orange[100]!, //5
    Colors.purple[100]!, //6
    Colors.teal[100]!, //7
    Colors.indigo[100]!, //8
    Colors.amber[100]!, //9
    Colors.deepOrange[100]!, //10
    Colors.lightBlueAccent[100]!, //11
    Colors.lime[100]!, //12
    Colors.cyan[100]!, //13
  ];

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

  void handleStartButtonTap(BuildContext context, String activity) async {
    // Handle the onPressed action for the "Start" button here
    // ignore: avoid_print
    print('Started: $activity');

    if (activity == 'Morning Meditation') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MorningMeds()
        ),
      );
    }
    if (activity == 'Night Music') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NightMain(),
        ),
      );
    }
    if (activity == 'Gratitude') {
      // Check activity completion status before navigating to VideoApp
      bool activityCompleted = await checkActivityCompletionStatus();

      if (!activityCompleted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoApp()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Activity Already Completed'),
              content: const Text(
                  'You have already completed the activity within the last 24 hours.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    if (activity == 'Mental Marathon') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedPage(),
        ),
      );
    }
    if (activity == 'Sherlock Holmes') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LetsPlay(),
        ),
      );
    }
    if (activity == 'Daily Thoughts') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DailyQuotesScreen(),
        ),
      );
    }
    if (activity == 'Study Music') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StudyMusicScreen(),
        ),
      );
    }
    if (activity == 'Kindness Challenge') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KindnessPageClass(),
        ),
      );
    }
    if (activity == 'Affirmation') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AffirmationApp(),
        ),
      );
    }
    if (activity == 'Music') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMusic(),
        ),
      );
    }
    if (activity == 'Tratak') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TratakaIntroScreen(),
        ),
      );
    }
    if (activity == 'Power nap') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PowerNapList(),
        ),
      );
    }
    if (activity == 'Journal') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const JournalScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (activityCompleted == null) {
      return const CircularProgressIndicator(); // Show loading indicator while initializing
    }
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              activities[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          // Added

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
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => handleStartButtonTap(
                                context, activities[index]),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.bgColor,
                              backgroundColor: AppColors.primaryColor,
                            ),
                            child: const Text(
                              'Start',
                              style: TextStyle(
                                fontSize: 15,
                              ),
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
