import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Games/games.dart';
import 'package:MindFulMe/Graphs/resources/app_resources.dart';
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
        children: const [
          HomePageUI(),
          CardView(),
          ChartReportTemplate(),
          GamesPage(),
          ProfileInfoPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13.0,
            vertical: 11,
          ),
          child: GNav(
            backgroundColor: AppColors.primaryColor,
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white,
            gap: 6,
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