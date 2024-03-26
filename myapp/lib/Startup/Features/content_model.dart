import 'package:MindFulMe/Startup/Features/onbording.dart';
import 'package:flutter/material.dart';

class OnbordingContent extends StatefulWidget {
  const OnbordingContent({super.key});

  @override
  State<OnbordingContent> createState() => _OnbordingContentState();
}

class _OnbordingContentState extends State<OnbordingContent> {
  final PageController _pageController = PageController();

  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'color': '#ffe24e',
      'title': 'Engaging Activities',
      'image': 'assets/GIF/Features/gif1.json',
      'description': "Engage in guided meditations, breathing "
          "exercises, and yoga sessions to cultivate inner "
          "calm and mindfulness in your daily life. ",
      'skip': true
    },
    {
      'color': '#45d1ed',
      'title': 'Challenging Games',
      'image': 'assets/GIF/Features/gif2.json',
      'description': "Stimulate your mind and challenge yourself "
          "with a collection of mental exercises and brain "
          "games designed to boost cognitive agility. ",
      'skip': true
    },
    {
      'color': '#31b77a',
      'title': 'Knowledge Treasure',
      'image': 'assets/GIF/Features/gif3.json',
      'description': "Explore a treasure trove of tips, facts, and "
          "articles about mental health—empowering you "
          "with knowledge and insights to support your well-being. ",
      'skip': true
    },
    {
      'color': '#8b21ed',
      'title': 'Progress Tracking',
      'image': 'assets/GIF/Features/gif4.json',
      'description':
          "Track your progress! Receive weekly reports summarizing your activities, "
              "games played, mood tracking, and other metrics— "
              "empowering you to visualize your growth and wellness journey. ",
      'skip': true
    },
    {
      'color': '#5342d4',
      'title': 'Mood Insights',
      'image': 'assets/GIF/Features/gif5.json',
      'description': "Log and track your moods and emotions effortlessly. "
          "Gain valuable insights into your emotional well-being, empowering you "
          "to understand patterns and make informed choices. ",
      'skip': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return OnboardingScreen(
                index: index,
                color: _pages[index]['color'],
                title: _pages[index]['title'],
                description: _pages[index]['description'],
                jsonFile: _pages[index]['image'],
                skip: _pages[index]['skip'],
                onTab: onNextPage,
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if (_activePage == 0) {
      color = '#ffe24e';
    } else if (_activePage == 1) {
      color = '#45d1ed';
    } else if (_activePage == 2) {
      color = '#31b77a';
    } else if (_activePage == 3) {
      color = '#8b21ed';
    } else {
      color = '#5342d4';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: hexToColor(color),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade100,
      ),
    );
  }
}
