import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:MindFulMe/Activities/Journal/journalview.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        for (var doc in querySnapshot.docs) {
          fetchedNotes.add(
            {
              'title': doc['title'],
              'timestamp': doc[
                  'timestamp'], // assuming there's a 'timestamp' field in your document
            },
          );
        }
        // Update the UI with the fetched notes
        setState(
          () {
            notes = fetchedNotes;
          },
        );
      }
    } catch (e) {
      // ignore: avoid_print
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

  void _showOptions(BuildContext context, String noteText) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pinNoteAndCloseBottomSheet(context, noteText);
                },
                child: const Text('Pin'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add your action for deleting the note
                  _deleteNoteAndCloseBottomSheet(context, noteText);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pinNoteAndCloseBottomSheet(BuildContext context, String noteText) {
    Navigator.pop(context);
  }

  void _deleteNoteAndCloseBottomSheet(BuildContext context, String noteText) {
    Navigator.pop(context);
  }

  // ignore: unused_element
  void _deleteNoteAndCloseDialog(BuildContext context, String noteText) {
    // Add your code here to delete the note
    // Once deleted, you can update the UI and close the dialog if needed
    Navigator.pop(context); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
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
            onLongPress: () {
              _showOptions(context, noteText);
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
        child: const Icon(Icons.add),
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
          title: const Text('Add Title for your Note'),
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
            decoration: const InputDecoration(hintText: 'Enter your title'),
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
                        .set(
                      {
                        'title': newNote,
                        'timestamp': Timestamp.now(), // Add current timestamp
                      },
                    );
                    // Update the UI to reflect the added note
                    setState(
                      () {
                        notes.add(
                            {'title': newNote, 'timestamp': Timestamp.now()});
                      },
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    _navigateToNoteDetailScreen(context, newNote);
                  }
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
