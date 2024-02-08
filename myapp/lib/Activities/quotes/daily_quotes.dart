import 'package:flutter/material.dart';
import 'package:myapp/Activities/quotes/daily_quote.dart';
import 'package:myapp/Activities/quotes/person_quote.dart';

class DailyQuotesScreen extends StatefulWidget {
  @override
  _DailyQuotesScreenState createState() => _DailyQuotesScreenState();
}

class _DailyQuotesScreenState extends State<DailyQuotesScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _fragments = <Widget>[
    DailyQuotePage(),
    PersonQuote(),
    DailyQuotePage(),
    CallsFragment(),
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

class DailyThoughtsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Daily Thoughts Fragment',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ChatsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chats Fragment',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class CallsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Calls Fragment',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
