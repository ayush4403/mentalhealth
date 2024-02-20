import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  bool _isPasswordVisible = false;
  String _password = ''; // Initial hidden password

  TextEditingController _nameController =
      TextEditingController(text: 'John Doe');
  TextEditingController _birthDateController =
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
        title: Text('Personal Information'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/batman.jpg'),
              ),
            ),
            SizedBox(height: 20),
            _buildInfoField('Name', _nameController, editable: true),
            // _buildInfoField('Email', 'john.doe@example.com'),
            Row(
              children: [
                Expanded(
                  child: _buildInfoField('Birth Date', _birthDateController,
                      editable: false),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            _buildPasswordField(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _undoChanges,
                  child: Text('Undo Changes'),
                ),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('Save'),
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
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          editable
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
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
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
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
