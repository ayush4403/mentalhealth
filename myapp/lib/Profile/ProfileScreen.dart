// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:MindFulMe/Profile/PersonelInfo.dart';
import 'package:MindFulMe/Startup/Registration/signin.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

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
              context,
              'Personal Information',
              Icons.person,
              Colors.blue[100]!,
            ),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Emergency Contact',
              Icons.contact_phone,
              Colors.red[100]!,
            ),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Submit Feedback',
              Icons.feedback,
              Colors.green[100]!,
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Security & Privacy', Colors.white),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Security',
              Icons.security,
              Colors.yellow[100]!,
            ),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Help Center',
              Icons.help,
              Colors.orange[100]!,
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Danger Zone', Colors.white),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Close Account',
              Icons.close,
              Colors.purple[100]!,
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSectionButton(
      BuildContext context, String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color, // Use the color provided in the function parameter
        borderRadius: BorderRadius.circular(20.0), // Increased roundness here
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: Icon(
          icon,
          color: Colors.black, // Icon color changed to black
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.black), // Arrow icon remains the same
        onTap: () {
          if (title == 'Personal Information') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalInformationPage(),
              ),
            );
          }
          // Add navigation logic for other buttons here
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors
            .white, // Using white color for the logout button as in your original code
        borderRadius: BorderRadius.circular(20.0), // Increased roundness here
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        trailing:
            const Icon(Icons.logout, color: Colors.black), // Logout icon added
        onTap: () {
          _showLogoutDialog(context); // Show logout confirmation dialog
        },
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
