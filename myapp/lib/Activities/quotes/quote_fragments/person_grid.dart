import 'package:flutter/material.dart';
import 'package:MindFulMe/Activities/quotes/quote_fragments/person_view.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> images = [
    'assets/Images/quotes/GuruGopalDas.jpg',
    'assets/Images/quotes/Swami_Vivekananda.jpg',
    'assets/Images/quotes/Sadhguru.jpg',
    'assets/Images/quotes/dr_apj.jpg',
    'assets/Images/quotes/Virat_Kohli.jpg',
    'assets/Images/quotes/Dhoni.jpg',
    'assets/Images/quotes/al_en.jpg',
    'assets/Images/quotes/bill_gates.jpg',
    'assets/Images/quotes/elon_musk.jpg',
    'assets/Images/quotes/Andrew_Tate.jpg',
  ];

  final List<String> names = [
    'Guru Gopal Das',
    'Swami Vivekananda',
    'Sadhguru',
    'Dr. APJ Abdul Kalam',
    'Virat Kohli',
    'Mahendra Singh Dhoni',
    'Albert Einstein',
    'Bill Gates',
    'Elon Musk',
    'Andrew Tate',
  ];

  final List<String> queryname = [
    'GuruGopalDas',
    'SwamiVivekananda',
    'SadhGuru',
    'APJ',
    'ViratKohli',
    'MSD',
    'AlbertEinstein',
    'BillGates',
    'ElonMusk',
    'AndrewTate',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              clipBehavior: Clip.hardEdge,
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 15.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonImageWithText(
                          queryname: queryname[index],
                        ),
                      ),
                    );
                    // ignore: avoid_print
                    print(queryname[index]);
                  },
                  child: Card(
                    key: ValueKey<String>(images[index]),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  )),
                              child: Text(
                                names[
                                    index], // Displaying separate name for each card
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
