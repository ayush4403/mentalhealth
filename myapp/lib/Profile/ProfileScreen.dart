// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:myapp/Profile/PersonelInfo.dart';
import 'package:myapp/Startup/Registration/signin.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'General Settings', Colors.white),
            const SizedBox(height: 8),
            _buildSectionButton(
                context, 'Personal Information', Colors.blue[100]!),
            const SizedBox(height: 8),
            _buildSectionButton(context, 'Emergency Contact', Colors.red[100]!),
            const SizedBox(height: 8),
            _buildSectionButton(context, 'Submit Feedback', Colors.green[100]!),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Security & Privacy', Colors.white),
            const SizedBox(height: 8),
            _buildSectionButton(context, 'Security', Colors.yellow[100]!),
            const SizedBox(height: 8),
            _buildSectionButton(context, 'Help Center', Colors.orange[100]!),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Danger Zone', Colors.white),
            const SizedBox(height: 8),
            _buildSectionButton(context, 'Close Account', Colors.purple[100]!),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Log Out', Colors.white),
            const SizedBox(height: 8),
            _buildLogoutButton(context), // Changed to call the logout method
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return FadeTransition(
      opacity: ModalRoute.of(context)!.animation!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionButton(BuildContext context, String title, Color color) {
    return FadeTransition(
      opacity: ModalRoute.of(context)!.animation!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            if (title == 'Personal Information') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalInformationPage()),
              );
            }
            // Add navigation logic for other buttons here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return FadeTransition(
      opacity: ModalRoute.of(context)!.animation!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            _showLogoutDialog(context); // Show logout confirmation dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[100],
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Do you want to Log Out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Close the dialog
                // Navigate to the sign-in page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
