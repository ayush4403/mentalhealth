// ignore_for_file: file_names
import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  bool _isPasswordVisible = false;
  final String _password = ''; // Initial hidden password

  final TextEditingController _nameController =
      TextEditingController(text: 'John Doe');
  final TextEditingController _birthDateController =
      TextEditingController(text: 'January 1, 1990');

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _undoChanges() {
    _nameController.text = 'John Doe';
    _birthDateController.text = 'January 1, 1990';
    // You can add similar logic to revert changes for other fields if needed
  }

  void _saveChanges() {
    String name = _nameController.text;
    String birthDate = _birthDateController.text;
    // You can add logic to save changes here
    // ignore: avoid_print
    print('Name: $name, Birth Date: $birthDate');
    Navigator.of(context)
        .pop(); // Navigate back to the previous screen (Account Settings)
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthDateController.text =
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Information',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/batman.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoField('Name', _nameController, editable: true),
            // _buildInfoField('Email', 'john.doe@example.com'),
            Row(
              children: [
                Expanded(
                  child: _buildInfoField('Birth Date', _birthDateController,
                      editable: false),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            _buildPasswordField(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _undoChanges,
                  child: const Text('Undo Changes'),
                ),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller,
      {bool editable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          editable
              ? TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  controller.text,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Text(
                  _isPasswordVisible ? _password : '*' * _password.length,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
