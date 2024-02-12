import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class ImageWithText extends StatefulWidget {
  @override
  _ImageWithTextState createState() => _ImageWithTextState();
}

class _ImageWithTextState extends State<ImageWithText> {
  late Future<List<Map<String, dynamic>>> _imageData;
  final _random = Random();

  List<String> descriptions = [
    "Stay motivated and never give up!",
    "Push yourself because no one else is going to do it for you.",
    "Success doesn't just find you. You have to go out and get it.",
    "The harder you work for something, the greater you'll feel when you achieve it.",
    "Don't stop when you're tired. Stop when you're done.",
    "Wake up with determination. Go to bed with satisfaction.",
    "It's going to be hard, but hard does not mean impossible.",
    "Success is what happens after you have survived all your mistakes.",
    "Dream it. Believe it. Build it.",
    "The only bad workout is the one that didn't happen."
  ];

  @override
  void initState() {
    super.initState();
    _imageData = fetchImageData();
  }

  Future<List<Map<String, dynamic>>> fetchImageData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/random?count=10&query=&client_id=XhrMaB2QalO0YMRnfM6iaXwNfYDDIlDUbeK49ABfWyg'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data.map((dynamic item) => {
            'imageUrl': item['urls']['regular'],
            'description': descriptions[_random.nextInt(descriptions.length)],
          }));
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images with Text'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _imageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ImageItem(
                  imageUrl: snapshot.data![index]['imageUrl'],
                  customDescription: snapshot.data![index]['description'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imageUrl;
  final String customDescription;

  const ImageItem({
    Key? key,
    required this.imageUrl,
    required this.customDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        Text(
          customDescription,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Image With Text',
    home: ImageWithText(),
  ));
}
