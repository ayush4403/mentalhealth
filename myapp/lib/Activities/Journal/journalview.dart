import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

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
  bool _istextsaved = false;
  String currentText = '';

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
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading text from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note Details'),
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
                    TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter your note'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showColorPicker();
          },
          child: const Icon(Icons.color_lens),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // ignore: unused_local_variable
    final bool textModified = _textEditingController.text != currentText;
    if (_istextsaved || _textEditingController.text.isEmpty) {
      return true;
    }
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Save Changes?'),
            content:
                const Text('Do you want to save the changes to this note?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                  await _saveNote();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
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
            .set({'text': newText}, SetOptions(merge: true));
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

  void _showColorPicker() {
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
                  _backgroundColor = color;
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

  Future<void> _deleteNote() async {
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
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true); // Signal that note is deleted
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting note: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete note. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
