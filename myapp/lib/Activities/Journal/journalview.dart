import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart'; // Import Firestore

class NoteDetailScreen extends StatefulWidget {
  final String noteText;

  const NoteDetailScreen({super.key, required this.noteText});

  @override
  // ignore: library_private_types_in_public_api
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _textEditingController;
  Color _backgroundColor = Colors.white;
  // ignore: unused_field
  bool _istextsaved = false;
  String currentText = '';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _loadTextFromFirestore();
  }

  Future<void> _loadTextFromFirestore() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Journal')
            .doc('Notes')
            .collection('Title')
            .doc(widget.noteText)
            .get();

        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;
          setState(() {
            _textEditingController.text = data['text'] ?? '';
            _backgroundColor =
                Color(data['backgroundColor'] ?? Colors.white.value);
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading text from Firestore: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // If the user picked an image, update the state
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_selectedImage != null)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Image.file(_selectedImage!),
          ),
        Stack(
          children: [
            TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your note',
              ),
              onTap: () {
                // Place the image where the cursor is
                if (_selectedImage != null) {
                  final TextEditingValue value = _textEditingController.value;
                  final TextSelection selection = value.selection.copyWith(
                    baseOffset: 0, // Place cursor at the start
                    extentOffset: 0, // Place cursor at the start
                  );
                  _textEditingController.value = value.copyWith(
                    selection: selection,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showColorPickerNew() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Background Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _backgroundColor,
              onColorChanged: (color) {
                setState(() {
                  _backgroundColor = color.withOpacity(0.5); // lighter color
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: avoid_unnecessary_containers
        title: Container(
          child: const Text(
            'Note Details',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Note?'),
                  content: const Text('Do you want to delete the note?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(false);
                        await _deleteNote();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.attach_file), // Add icon for uploading image
            onPressed: () {
              _pickImage();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              await _saveNote();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside text field
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.topLeft,
              color: _backgroundColor,
              child: Text(
                widget.noteText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: _backgroundColor,
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  _buildTextField(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showColorPickerNew();
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }

  Future<void> _saveNote() async {
    try {
      final String newText = _textEditingController.text;

      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Journal')
            .doc('Notes')
            .collection('Title')
            .doc(widget.noteText)
            .set({
          'text': newText,
          'backgroundColor': _backgroundColor.value, // Save color value
        }, SetOptions(merge: true));
      } else {
        // ignore: avoid_print
        print(newText);
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _istextsaved = true;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error saving note: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save note. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> _deleteNote() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Journal')
            .doc('Notes')
            .collection('Title')
            .doc(widget.noteText)
            .delete();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        return true; // Signal success
      }
      return false; // Signal failure
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting note: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete note. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Signal failure
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
