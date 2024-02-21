import 'package:flutter/material.dart';

class HomePageUI extends StatelessWidget {
  const HomePageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/profile_picture.jpg'),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'User Name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Activity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // Add activity content here
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle start button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Start'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildButton(title: 'Tips'),
                  _buildButton(title: 'Facts'),
                  _buildButton(title: 'Articles'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String title}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
