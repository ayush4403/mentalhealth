// daily_quotes.dart

//import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:math';
//import 'dummy_data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DailyQuotePage extends StatefulWidget {
  @override
  _DailyQuotePageState createState() => _DailyQuotePageState();
}

class _DailyQuotePageState extends State<DailyQuotePage> {
  String _currentQuote = '';

  @override
  void initState() {
    super.initState();
    _fetchQuotesFromStorage();
  }

  Future<void> _fetchQuotesFromStorage() async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('quotes.txt');
      final List<int>? data = (await storageReference.getData())?.toList();
      final String quotesContent = String.fromCharCodes(data as Iterable<int>);
      List<String> quotes = quotesContent.split('\n');
      int randomIndex = Random().nextInt(quotes.length);

      setState(() {
        _currentQuote = quotes[randomIndex];
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching quotes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        title: const Text(
          'Daily Motivational Quote',
          style: TextStyle(
            color: Colors.white, // Change text color to white
            fontSize: 20, // Change font size
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
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
                onPressed: _fetchQuotesFromStorage,
                child: const Text('Generate New Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
