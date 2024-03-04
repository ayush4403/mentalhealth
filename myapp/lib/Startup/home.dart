import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Games/games.dart';
import 'package:MindFulMe/Home/homeui.dart';
import 'package:MindFulMe/Profile/profile.dart';
import 'package:MindFulMe/Report/report.dart';
//import 'package:myapp/test/single_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController _pageController;
  bool shownavbar = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void add() {
    currentIndex = 1;
  }

  bool shonavbar(bool visibility) {
    return visibility;
  }

  void randomFunction() {
    // Generate a random number between 0 and 1

    // Navigate to a random page based on the generated number
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          const HomePageUI(),
          const CardView(),
          ChartReportTemplate(
            description: '',
            title: '',
            onTap: () {
              // ignore: avoid_print
              print('chart');
            },
          ),
          const GamesPage(),
          const ProfilePage()
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: shownavbar,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.blue,
          currentIndex: currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          backgroundColor: Colors.black, // Set background color
          type: BottomNavigationBarType
              .fixed, // Set type to fixed for more than 3 items
          elevation: 0, // Remove shadow

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity_rounded),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset_rounded),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
