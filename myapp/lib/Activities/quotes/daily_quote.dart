// daily_quotes.dart

import 'package:flutter/material.dart';
import 'dart:math';
import 'dummy_data.dart';

class DailyQuotePage extends StatefulWidget {
  @override
  _DailyQuotePageState createState() => _DailyQuotePageState();
}

class _DailyQuotePageState extends State<DailyQuotePage> {
  String _currentQuote = '';

  @override
  void initState() {
    super.initState();
    _setCurrentQuote();
  }

  void _setCurrentQuote() {
    // Generate a random index to select a quote
    int randomIndex = Random().nextInt(motivationalQuotes.length);
    setState(() {
      _currentQuote = motivationalQuotes[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Motivational Quote'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentQuote,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _setCurrentQuote,
                child: const Text('Generate New Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
