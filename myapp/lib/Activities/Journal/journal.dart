import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:myapp/Activities/Journal/journalview.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();

    _fetchNotes();
  }

  void _fetchNotes() async {
    try {
      // Get the current user
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the notes collection for the current user
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Journal')
            .doc('Notes')
            .collection('Title')
            .get();

        // Iterate over the documents and extract the note text and timestamp
        List<Map<String, dynamic>> fetchedNotes = [];
        querySnapshot.docs.forEach((doc) {
          fetchedNotes.add({
            'title': doc['title'],
            'timestamp': doc[
                'timestamp'], // assuming there's a 'timestamp' field in your document
          });
        });

        // Update the UI with the fetched notes
        setState(() {
          notes = fetchedNotes;
        });
      }
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  void _navigateToNoteDetailScreen(BuildContext context, String note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailScreen(noteText: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: GridView.builder(
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          String noteText = notes[index]['title'];
          String timestamp = _formatTimestamp(notes[index]['timestamp']);
          return GestureDetector(
            onTap: () {
              _navigateToNoteDetailScreen(context, noteText);
            },
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(noteText),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(timestamp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    //
    DateTime dateTime = timestamp.toDate();

    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
  }

  void _showNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newNote = '';
        return AlertDialog(
          title: Text('Add Title for your Note'),
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
            decoration: InputDecoration(hintText: 'Enter your title'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (newNote.isNotEmpty) {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // Add the new note to Firestore
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user.uid)
                        .collection('Journal')
                        .doc('Notes')
                        .collection('Title')
                        .doc(newNote)
                        .set({
                      'title': newNote,
                      'timestamp': Timestamp.now(), // Add current timestamp
                    });
                    // Update the UI to reflect the added note
                    setState(() {
                      notes.add(
                          {'title': newNote, 'timestamp': Timestamp.now()});
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
