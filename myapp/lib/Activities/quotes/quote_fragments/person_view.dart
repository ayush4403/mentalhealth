import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:myapp/Activities/quotes/quote_fragments/person_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonImageWithText extends StatefulWidget {
  final String queryname;

  const PersonImageWithText({super.key, required this.queryname});

  @override
  _PersonImageWithTextState createState() => _PersonImageWithTextState();
}

class _PersonImageWithTextState extends State<PersonImageWithText> {
  late Future<List<Map<String, dynamic>>> _imageData;
  final _random = Random();
  late SharedPreferences _prefs;
  late int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _imageData = fetchImageData();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(hours: 24), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _getCurrentImageListLength();
        _imageData = fetchImageData();
      });
    });
  }

  int _getCurrentImageListLength() {
    return _getCurrentImageList().length;
  }

  List<String> _getCurrentImageList() {
    switch (widget.queryname) {
      case 'AlbertEinstein':
        return alberteinstein;
      case 'AndrewTate':
        return andrewtate;
      case 'APJ':
        return apj;
      case 'BillGates':
        return billgates;
      case 'ElonMusk':
        return elon_musk;
      case 'GuruGopalDas':
        return gurugopaldas;
      case 'MSD':
        return msd;
      case 'SadhGuru':
        return sadhguru;
      case 'SwamiVivekananda':
        return swamivivekananda;
      case 'ViratKohli':
        return viratkohli;
      default:
        throw Exception('Invalid query name: ${widget.queryname}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchImageData() async {
    try {
      List<String> imageList = getImageList(widget.queryname);
      return List<Map<String, dynamic>>.generate(imageList.length, (index) {
        return {
          'imageUrl': imageList[index],
          'description': quoteMap[widget.queryname]![
              _random.nextInt(quoteMap[widget.queryname]!.length)],
        };
      });
    } catch (error) {
      throw Exception('Failed to load images: $error');
    }
  }

  List<String> getImageList(String queryName) {
    switch (queryName) {
      case 'AlbertEinstein':
        return alberteinstein;
      case 'AndrewTate':
        return andrewtate;
      case 'APJ':
        return apj;
      case 'BillGates':
        return billgates;
      case 'ElonMusk':
        return elon_musk;
      case 'GuruGopalDas':
        return gurugopaldas;
      case 'MSD':
        return msd;
      case 'SadhGuru':
        return sadhguru;
      case 'SwamiVivekananda':
        return swamivivekananda;
      case 'ViratKohli':
        return viratkohli;
      default:
        throw Exception('Invalid query name: $queryName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.queryname),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _imageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ImageItem(
              imageUrl: snapshot.data![_currentIndex]['imageUrl'],
              customDescription: snapshot.data![_currentIndex]['description'],
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
            child: Image.asset(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
            )),
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
