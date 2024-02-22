import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class NoteDetailScreen extends StatefulWidget {
  final String noteText;

  NoteDetailScreen({required this.noteText});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _textEditingController;
  Color _backgroundColor = Colors.white;
  bool _istextsaved = false;

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
      print('Error loading text from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Note Details'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Note?'),
                    content: Text('Do you want to delete the note?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop(false);
                          await _deleteNote();
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
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
                padding: EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.noteText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                color: _backgroundColor,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Enter your note'),
                      style: TextStyle(fontSize: 16),
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
          child: Icon(Icons.color_lens),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_istextsaved) {
      return true;
    }
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Save Changes?'),
            content: Text('Do you want to save the changes to this note?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                  await _saveNote();
                },
                child: Text('Yes'),
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
        print(newText);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _istextsaved = true;
      });
    } catch (e) {
      print('Error saving note: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
          title: Text('Select Background Color'),
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
              child: Text('OK'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Note deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context, true); // Signal that note is deleted
      }
    } catch (e) {
      print('Error deleting note: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
