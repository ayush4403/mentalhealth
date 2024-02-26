import 'package:MindFulMe/Activities/cardview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'journalview.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field, prefer_final_fields
  Color _backgroundColor = Colors.white;
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> filteredNotes = []; // Added for filtered notes
  bool _showSearchText = true;
  bool isGridView = true;
  String name = 'List view';
  String name1 = 'Grid view';

  bool sortLatest = true;
  String timecreated = 'Sort by oldest';
  String timecreated1 = 'Sort by latest';

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showSearchText = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fetchNotes() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('Journal')
            .doc('Notes')
            .collection('Title')
            .orderBy('timestamp',
                descending: sortLatest) // sort based on the timestamp
            .get();

        List<Map<String, dynamic>> fetchedNotes = [];
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          fetchedNotes.add(
            {
              'title': data['title'],
              'timestamp': data['timestamp'],
              'backgroundColor': data['backgroundColor'] ?? Colors.white.value,
            },
          );
        }

        setState(() {
          notes = fetchedNotes;
          filteredNotes =
              fetchedNotes; // Initialize filtered notes with all notes
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching notes: $e');
    }
  }

  void _navigateToNoteDetailScreen(BuildContext context, String note) async {
    final isNoteDeleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailScreen(
          noteText: note,
        ),
      ),
    );

    // Update the UI based on the result of the note deletion
    if (isNoteDeleted == true) {
      // Reload notes if the note was deleted
      _fetchNotes();
    }
  }

  void _toggleSortOrder() {
    setState(() {
      sortLatest = !sortLatest;
    });
    _fetchNotes(); // fetch notes again based on the new sorting option
    _animateNotes();
  }

  void _animateNotes() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 111, 186),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(const CardView());
          },
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _showSearchText
              ? const Text(
                  'Journal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : AnimatedOpacity(
                  opacity: _showSearchText ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    'Search Your Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        actions: [
          if (!_showSearchText) // Only show search icon if search is enabled

            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: NotesSearch(notes));
              },
            ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  isGridView ? name : name1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  setState(
                    () {
                      isGridView = !isGridView;
                    },
                  );
                },
              ),
              PopupMenuItem(
                child: Text(
                  sortLatest ? timecreated : timecreated1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onTap: () {
                  _toggleSortOrder();
                },
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 240, 242, 244),
      body: isGridView ? _buildGridView() : _buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridView() {
    return SlideTransition(
      position: _animation,
      child: GridView.builder(
        itemCount: filteredNotes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          String noteText = filteredNotes[index]['title'];
          String timestamp =
              _formatTimestamp(filteredNotes[index]['timestamp']);
          Color backgroundColor =
              filteredNotes[index]['backgroundColor'] != null
                  ? Color(filteredNotes[index]['backgroundColor'])
                  : Colors.white;
          return GestureDetector(
            onLongPress: () {
              _showDeleteDialog(context, noteText);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(noteText),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(timestamp),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String noteText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note?'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteNoteFromFirestore(noteText);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// Add this method to delete the note from Firestore
  Future<void> _deleteNoteFromFirestore(String noteText) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Journal')
          .doc('Notes')
          .collection('Title')
          .doc(noteText)
          .delete();

      // Remove the deleted note from the UI
      setState(() {
        notes.removeWhere((note) => note['title'] == noteText);
        filteredNotes.removeWhere((note) => note['title'] == noteText);
      });
    }
  }

  Widget _buildListView() {
    return SlideTransition(
      position: _animation,
      child: ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          String noteText = filteredNotes[index]['title'];
          String timestamp =
              _formatTimestamp(filteredNotes[index]['timestamp']);
          Color backgroundColor =
              filteredNotes[index]['backgroundColor'] != null
                  ? Color(filteredNotes[index]['backgroundColor'])
                  : Colors.white;

          return GestureDetector(
            onLongPress: () {
              _showDeleteDialog(context, noteText);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: backgroundColor, // Set background color here
              child: ListTile(
                title: Text(noteText),
                subtitle: Text(timestamp),
                onTap: () {
                  _navigateToNoteDetailScreen(context, noteText);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    // ignore: unnecessary_null_comparison
    if (timestamp != null) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
    } else {
      return 'No timestamp available'; // Return a default value or handle the null case accordingly
    }
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
                        'timestamp': Timestamp.now(),
                      },
                    );
                    setState(
                      () {
                        notes.add(
                            {'title': newNote, 'timestamp': Timestamp.now()});
                      },
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
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

// Add a class for the search functionality

class NotesSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> notes;

  NotesSearch(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for AppBar (e.g., clear query button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        color: Colors.black,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the AppBar (e.g., back arrow)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on the search query
    final List<Map<String, dynamic>> filteredNotes = notes
        .where(
            (note) => note['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(filteredNotes);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions while the user types in the search field
    final List<Map<String, dynamic>> filteredNotes = notes
        .where(
            (note) => note['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(filteredNotes);
  }

  Widget _buildSearchResults(List<Map<String, dynamic>> filteredNotes) {
    return ListView.builder(
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) {
        final String noteText = filteredNotes[index]['title'];
        final String timestamp = DateFormat('dd-MM-yyyy HH:mm:ss')
            .format(filteredNotes[index]['timestamp'].toDate());

        return ListTile(
          title: Text(noteText),
          subtitle: Text(timestamp),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NoteDetailScreen(noteText: noteText)));
          },
        );
      },
    );
  }
}
