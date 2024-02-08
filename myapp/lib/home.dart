import 'package:flutter/material.dart';
import 'package:myapp/Activities/cardview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController _pageController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          Container(
              color: Colors.red, child: const Center(child: Text('Home'))),
          CardView(),
          Container(
              color: Colors.blue, child: const Center(child: Text('Report'))),
          Container(
              color: Colors.orange, child: const Center(child: Text('Games'))),
          Container(
              color: Colors.purple,
              child: const Center(child: Text('Profile'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.home_sharp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_sharp),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
