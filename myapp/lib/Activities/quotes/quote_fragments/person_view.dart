import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:myapp/Activities/quotes/quote_fragments/person_data.dart';
import 'package:myapp/Activities/quotes/quote_fragments/person_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonImageWithText extends StatefulWidget {
  final String queryname;

  const PersonImageWithText({super.key, required this.queryname});

  @override
  // ignore: library_private_types_in_public_api
  _PersonImageWithTextState createState() => _PersonImageWithTextState();
}

class _PersonImageWithTextState extends State<PersonImageWithText> {
  late Future<List<Map<String, dynamic>>> _imageData;
  final _random = Random();
  // ignore: unused_field
  late SharedPreferences _prefs;
  late int _currentIndex = 0;
  // ignore: unused_field
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _imageData = fetchImageData();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
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
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const PersonScreen());
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
            return const Center(child: CircularProgressIndicator());
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
            child: Image.asset(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
            )),
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
