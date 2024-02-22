import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/cardview.dart';
import 'package:MindFulMe/Activities/quotes/quote_fragments/person_grid.dart';
import 'package:MindFulMe/Activities/quotes/quote_fragments/random_quote.dart';
import 'package:MindFulMe/Activities/quotes/quote_fragments/type_grid.dart';
//import 'package:myapp/Activities/quote_fragments/random_quote.dart';

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
    const Quotetopic(),
    const RandomQuote()
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

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
          'Daily Thoughts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 111, 186),
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
                            ? Icons.person_2_rounded
                            : index == 1
                                ? Icons.topic_rounded
                                : index == 2
                                    ? Icons.format_quote
                                    : Icons.call,
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        index == 0
                            ? 'Personalities'
                            : index == 1
                                ? 'Topics'
                                : index == 2
                                    ? 'Quotes'
                                    : 'Calls',
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
    );
  }
}
