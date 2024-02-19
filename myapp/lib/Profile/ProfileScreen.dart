import 'package:flutter/material.dart';
import 'package:myapp/Profile/PersonelInfo.dart';
//import 'package:quotes/PersonalInformationPage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            _buildSectionTitle(context, 'General Settings', Colors.white),
            SizedBox(height: 8),
            _buildSectionButton(
                context, 'Personal Information', Colors.blue[100]!),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Emergency Contact', Colors.red[100]!),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Submit Feedback', Colors.green[100]!),
            Divider(),
            SizedBox(height: 16),
            _buildSectionTitle(context, 'Security & Privacy', Colors.white),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Security', Colors.yellow[100]!),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Help Center', Colors.orange[100]!),
            Divider(),
            SizedBox(height: 16),
            _buildSectionTitle(context, 'Danger Zone', Colors.white),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Close Account', Colors.purple[100]!),
            Divider(),
            SizedBox(height: 16),
            _buildSectionTitle(context, 'Log Out', Colors.white),
            SizedBox(height: 8),
            _buildSectionButton(context, 'Log Out', Colors.teal[100]!),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return FadeTransition(
      opacity: ModalRoute.of(context)!.animation!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            if (title == 'Personal Information') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalInformationPage()),
              );
            }
            // Add navigation logic for other buttons here
          },
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
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
}
