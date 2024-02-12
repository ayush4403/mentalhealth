import 'package:flutter/material.dart';
//import 'package:myapp/Activities/quotes/extra_quote.dart';
import 'package:myapp/Activities/quotes/quote_fragments/person_grid.dart';
import 'package:myapp/Activities/quotes/quote_fragments/random_quote.dart';
//import 'package:myapp/Activities/quotes/random_quote.dart';

class DailyQuotesScreen extends StatefulWidget {
  const DailyQuotesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DailyQuotesScreenState createState() => _DailyQuotesScreenState();
}

class _DailyQuotesScreenState extends State<DailyQuotesScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _fragments = <Widget>[
    const PersonScreen(),
    RandomQuote(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Thoughts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
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
                                : index == 2
                                    ? Icons.insert_chart
                                    : Icons.call,
                        color:
                            _selectedIndex == index ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        index == 0
                            ? 'Quotes'
                            : index == 1
                                ? 'Chats'
                                : index == 2
                                    ? 'Status'
                                    : 'Calls',
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
