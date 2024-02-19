import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:myapp/Activities/quotes/quote_fragments/type_data.dart';

class ImageWithText extends StatefulWidget {
  final String queryname;

  const ImageWithText({super.key, required this.queryname});

  @override
  // ignore: library_private_types_in_public_api
  _ImageWithTextState createState() => _ImageWithTextState();
}

class _ImageWithTextState extends State<ImageWithText> {
  late Future<List<Map<String, dynamic>>> _imageData;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _imageData = fetchImageData();
  }

  Future<List<Map<String, dynamic>>> fetchImageData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/photos/random?count=10&query=${widget.queryname}&client_id=XhrMaB2QalO0YMRnfM6iaXwNfYDDIlDUbeK49ABfWyg'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data.map((dynamic item) => {
              'imageUrl': item['urls']['regular'],
              'description': quoteMap[widget.queryname]![
                  _random.nextInt(quoteMap[widget.queryname]!.length)],
            }));
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load images: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.queryname,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _imageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
    super.key,
    required this.imageUrl,
    required this.customDescription,
  });

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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            customDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}