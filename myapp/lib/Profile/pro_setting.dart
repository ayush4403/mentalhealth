import 'package:MindFulMe/Graphs/resources/app_resources.dart';
import 'package:MindFulMe/Profile/PersonelInfo.dart';
import 'package:MindFulMe/Profile/pro_info.dart';
import 'package:MindFulMe/Startup/Registration/signin.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const double kSpacingUnit = 10.0;

class ProSetting extends StatefulWidget {
  const ProSetting({super.key});

  @override
  State<ProSetting> createState() => _ProSettingState();
}

class _ProSettingState extends State<ProSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const ProfileInfoPage());
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),
            _buildSectionTitle(
              context,
              'General Settings',
              Colors.black,
            ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Container(
                height: 1,
                width: 500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _buildSectionTitle(context, 'Security & Privacy', Colors.black),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Container(
                height: 1,
                width: 500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _buildSectionTitle(context, 'Danger Zone', Colors.black),
            const SizedBox(height: 8),
            _buildSectionButton(
              context,
              'Close Account',
              Icons.close,
              Colors.purple[100]!,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Container(
                height: 1,
                width: 500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _buildSectionTitle(context, 'Log Out', Colors.black),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
            ),
            Positioned(
              top: 1.0,
              left: 18.0,
              right: 18.0,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
        borderRadius: BorderRadius.circular(30.0), // Increased roundness here
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
          color: Colors.primaries.last, // Icon color changed to black
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Colors.primaries.last), // Arrow icon remains the same
        onTap: () {
          if (title == 'Personal Information') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalInformationPage(),
              ),
            );
          }
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
        borderRadius: BorderRadius.circular(30.0), // Increased roundness here
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
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        trailing: Icon(Icons.logout,
            color: Colors.primaries.last),
        onTap: () {
          _showLogoutDialog(context);
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
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
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
