import 'package:flutter/material.dart';

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

  final List<String> alberteinstein = [
    'assets/Images/persons/AlberEinstein/1.jpg',
    'assets/Images/persons/AlberEinstein/2.jpg',
    'assets/Images/persons/AlberEinstein/3.jpg',
    'assets/Images/persons/AlberEinstein/4.jpg',
    'assets/Images/persons/AlberEinstein/5.jpg',
    'assets/Images/persons/AlberEinstein/6.jpg',
    'assets/Images/persons/AlberEinstein/7.jpg',
    'assets/Images/persons/AlberEinstein/8.jpg',
    'assets/Images/persons/AlberEinstein/9.jpg',
    'assets/Images/persons/AlberEinstein/10.jpg',
  ];
  final List<String> andrewtate = [
    'assets/Images/persons/AndrewTate/1.jpg',
    'assets/Images/persons/AndrewTate/2.jpg',
    'assets/Images/persons/AndrewTate/3.jpg',
    'assets/Images/persons/AndrewTate/4.jpg',
    'assets/Images/persons/AndrewTate/5.jpg',
    'assets/Images/persons/AndrewTate/6.jpg',
    'assets/Images/persons/AndrewTate/7.jpg',
    'assets/Images/persons/AndrewTate/8.jpg',
    'assets/Images/persons/AndrewTate/9.jpg',
    'assets/Images/persons/AndrewTate/10.jpg',
  ];
  final List<String> apj = [
    'assets/Images/persons/APJ/1.jpg',
    'assets/Images/persons/APJ/2.jpg',
    'assets/Images/persons/APJ/3.jpg',
    'assets/Images/persons/APJ/4.jpg',
    'assets/Images/persons/APJ/5.jpg',
    'assets/Images/persons/APJ/6.jpg',
    'assets/Images/persons/APJ/7.jpg',
    'assets/Images/persons/APJ/8.jpg',
    'assets/Images/persons/APJ/9.jpg',
    'assets/Images/persons/APJ/10.jpg',
  ];
  final List<String> billgates = [
    'assets/Images/persons/BillGates/1.jpg',
    'assets/Images/persons/BillGates/2.jpg',
    'assets/Images/persons/BillGates/3.jpg',
    'assets/Images/persons/BillGates/4.jpg',
    'assets/Images/persons/BillGates/5.jpg',
    'assets/Images/persons/BillGates/6.jpg',
    'assets/Images/persons/BillGates/7.jpg',
    'assets/Images/persons/BillGates/8.jpg',
    'assets/Images/persons/BillGates/9.jpg',
    'assets/Images/persons/BillGates/10.jpg',
  ];
  final List<String> elon_musk = [
    'assets/Images/persons/ElonMusk/1.jpg',
    'assets/Images/persons/ElonMusk/2.jpg',
    'assets/Images/persons/ElonMusk/3.jpg',
    'assets/Images/persons/ElonMusk/4.jpg',
    'assets/Images/persons/ElonMusk/5.jpg',
    'assets/Images/persons/ElonMusk/6.jpg',
    'assets/Images/persons/ElonMusk/7.jpg',
    'assets/Images/persons/ElonMusk/8.jpg',
    'assets/Images/persons/ElonMusk/9.jpg',
    'assets/Images/persons/ElonMusk/10.jpg',
  ];
  final List<String> gurugopaldas = [
    'assets/Images/persons/GuruGopalDas/1.jpg',
    'assets/Images/persons/GuruGopalDas/2.jpg',
    'assets/Images/persons/GuruGopalDas/3.jpg',
    'assets/Images/persons/GuruGopalDas/4.jpg',
    'assets/Images/persons/GuruGopalDas/5.jpg',
    'assets/Images/persons/GuruGopalDas/6.jpg',
    'assets/Images/persons/GuruGopalDas/7.jpg',
    'assets/Images/persons/GuruGopalDas/8.jpg',
    'assets/Images/persons/GuruGopalDas/9.jpg',
    'assets/Images/persons/GuruGopalDas/10.jpg',
  ];
  final List<String> msd = [
    'assets/Images/persons/MSD/1.jpg',
    'assets/Images/persons/MSD/2.jpg',
    'assets/Images/persons/MSD/3.jpg',
    'assets/Images/persons/MSD/4.jpg',
    'assets/Images/persons/MSD/5.jpg',
    'assets/Images/persons/MSD/6.jpg',
    'assets/Images/persons/MSD/7.jpg',
    'assets/Images/persons/MSD/8.jpg',
    'assets/Images/persons/MSD/9.jpg',
    'assets/Images/persons/MSD/10.jpg',
  ];
  final List<String> sadhguru = [
    'assets/Images/persons/SadhGuru/1.jpg',
    'assets/Images/persons/SadhGuru/2.jpg',
    'assets/Images/persons/SadhGuru/3.jpg',
    'assets/Images/persons/SadhGuru/4.jpg',
    'assets/Images/persons/SadhGuru/5.jpg',
    'assets/Images/persons/SadhGuru/6.jpg',
    'assets/Images/persons/SadhGuru/7.jpg',
    'assets/Images/persons/SadhGuru/8.jpg',
    'assets/Images/persons/SadhGuru/9.jpg',
    'assets/Images/persons/SadhGuru/10.jpg',
  ];
  final List<String> swamivivekananda = [
    'assets/Images/persons/SwamiVivekananda/1.jpg',
    'assets/Images/persons/SwamiVivekananda/2.jpg',
    'assets/Images/persons/SwamiVivekananda/3.jpg',
    'assets/Images/persons/SwamiVivekananda/4.jpg',
    'assets/Images/persons/SwamiVivekananda/5.jpg',
    'assets/Images/persons/SwamiVivekananda/6.jpg',
    'assets/Images/persons/SwamiVivekananda/7.jpg',
    'assets/Images/persons/SwamiVivekananda/8.jpg',
    'assets/Images/persons/SwamiVivekananda/9.jpg',
    'assets/Images/persons/SwamiVivekananda/10.jpg',
  ];
  final List<String> viratkohli = [
    'assets/Images/persons/ViratKohli/1.jpg',
    'assets/Images/persons/ViratKohli/2.jpg',
    'assets/Images/persons/ViratKohli/3.jpg',
    'assets/Images/persons/ViratKohli/4.jpg',
    'assets/Images/persons/ViratKohli/5.jpg',
    'assets/Images/persons/ViratKohli/6.jpg',
    'assets/Images/persons/ViratKohli/7.jpg',
    'assets/Images/persons/ViratKohli/8.jpg',
    'assets/Images/persons/ViratKohli/9.jpg',
    'assets/Images/persons/ViratKohli/10.jpg',
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
                        builder: (context) =>
                            DetailScreen(imagePath: images[index]),
                      ),
                    );
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

class DetailScreen extends StatelessWidget {
  final String imagePath;

  const DetailScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
