import 'package:flutter/material.dart';
import 'package:myapp/Activities/Morning_Meditation/BrainEntrainment.dart';
import 'package:myapp/Activities/Morning_Meditation/GuidedMed.dart';
import 'package:myapp/Activities/Morning_Meditation/Visualize.dart';
import 'package:myapp/Activities/cardview.dart';

class MorningMeditation extends StatefulWidget {
  const MorningMeditation({super.key});

  @override
  MorningMeditationState createState() => MorningMeditationState();
}

class MorningMeditationState extends State<MorningMeditation> {
  int _selectedIndex = 0;

  static final List<Widget> _fragments = <Widget>[
    const GuidedList(),
    const Visualize(),
    const BrainList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String br = 'BrainBeats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const CardView());
          },
        ),
        title: const Text(
          'Morning Meditation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          // Return false to disable the system back button
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color.fromARGB(255, 0, 111, 186),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  _fragments.length,
                  (index) => InkWell(
                    onTap: () {
                      _onItemTapped(index);
                    },
                    child: Column(
                      children: [
                        Icon(
                          index == 0
                              ? Icons.format_quote
                              : index == 1
                                  ? Icons.chat
                                  : Icons.insert_chart,
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          index == 0
                              ? 'Guided'
                              : index == 1
                                  ? 'Visualize'
                                  : 'BrainBeats',
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _fragments.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
