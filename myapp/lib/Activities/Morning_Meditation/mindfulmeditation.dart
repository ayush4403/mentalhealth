import 'package:flutter/material.dart';
import 'package:myapp/Activities/Morning_Meditation/BrainEntrainment.dart';
import 'package:myapp/Activities/Morning_Meditation/GuidedMed.dart';
//import 'package:myapp/Activities/Stress_Buster/stress_buster.dart';
import 'package:myapp/Activities/Morning_Meditation/Visualize.dart';

class MorningMeditation extends StatefulWidget {
  @override
  MorningMeditationState createState() => MorningMeditationState();
}

class MorningMeditationState extends State<MorningMeditation> {
  int _selectedIndex = 0;

  static List<Widget> _fragments = <Widget>[
    Guided(),
    Visualize(),
    BrainEntrainment(),
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
        title: Text('MorningMeditation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
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
                        color:
                            _selectedIndex == index ? Colors.blue : Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        index == 0
                            ? 'Guided'
                            : index == 1
                                ? 'Visualize'
                                : 'BrainBeats',
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.blue
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
    );
  }
}
