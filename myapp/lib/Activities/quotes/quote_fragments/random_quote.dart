import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class RandomQuote extends StatefulWidget {
  @override
  _RandomQuoteState createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  String _imageUrl = '';
  String _quote = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchQuoteAndImage();
  }

  Future<void> fetchQuoteAndImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await fetchQuote();
      await fetchImage();
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _quote = data['content'];
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  Future<void> fetchImage() async {
    // List of motivational and quote-related image URLs
    final imageUrls = [
      'https://source.unsplash.com/random/400x400?sig=${Random().nextInt(1000)}',
      'https://source.unsplash.com/featured/?motivation',
      'https://source.unsplash.com/featured/?quotes',
    ];

    final response = await http
        .get(Uri.parse(imageUrls[Random().nextInt(imageUrls.length)]));
    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = response.request!.url.toString();
      });
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _imageUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  Text(
                    _quote.isEmpty ? 'Loading quote...' : _quote,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchQuoteAndImage,
                    child: Text('Get New Quote and Image'),
                  ),
                ],
              ),
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Details'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
