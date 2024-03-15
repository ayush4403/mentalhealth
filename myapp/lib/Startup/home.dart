import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Games/games.dart';
import 'package:MindFulMe/Home/homeui.dart';
import 'package:MindFulMe/Profile/pro_info.dart';
import 'package:MindFulMe/Report/report.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
        children:  [
          HomePageUI(),
          CardView(),
          ChartReportTemplate(),
          GamesPage(),
          ProfileInfoPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15,
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.local_activity_rounded,
                text: 'Activity',
              ),
              GButton(
                icon: Icons.insert_chart_outlined,
                text: 'Report',
              ),
              GButton(
                icon: Icons.videogame_asset_rounded,
                text: 'Games',
              ),
              GButton(
                icon: Icons.person_4_rounded,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
