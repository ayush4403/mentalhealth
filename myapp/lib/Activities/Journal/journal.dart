import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'journalview.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> filteredNotes = []; // Added for filtered notes
  bool _showSearchText = true;
  bool isGridView = true;
  String name = 'List view';
  String name1 = 'Grid view';

  bool sortLatest = true;
  String timecreated = 'Sort by time created(oldest)';
  String timecreated1 = 'Sort by time created(latest)';

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 2), () {
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
        querySnapshot.docs.forEach((doc) {
          fetchedNotes.add({
            'title': doc['title'],
            'timestamp': doc['timestamp'],
          });
        });

        setState(() {
          notes = fetchedNotes;
          filteredNotes =
              fetchedNotes; // Initialize filtered notes with all notes
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

  void _toggleSortOrder() {
    setState(() {
      sortLatest = !sortLatest;
    });
    _fetchNotes(); // fetch notes again based on the new sorting option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _showSearchText
              ? Text('Journal')
              : AnimatedOpacity(
                  opacity: _showSearchText ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Search Your Notes',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
        ),
        actions: [
          if (!_showSearchText) // Only show search icon if search is enabled
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NotesSearch(notes));
              },
            ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(name),
                onTap: () {
                  setState(() {
                    isGridView = !isGridView;
                    name = name1;
                  });
                },
              ),
              PopupMenuItem(
                child: Text(sortLatest ? timecreated : timecreated1),
                onTap: () {
                  _toggleSortOrder();
                },
              ),
            ],
          ),
        ],
      ),
      body: isGridView ? _buildGridView() : _buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridView() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(_animation),
      child: GridView.builder(
        itemCount: filteredNotes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          String noteText = filteredNotes[index]['title'];
          String timestamp =
              _formatTimestamp(filteredNotes[index]['timestamp']);
          return GestureDetector(
            onTap: () {
              _navigateToNoteDetailScreen(context, noteText);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0 * _animation.value),
              ),
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
    );
  }

  Widget _buildListView() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(_animation),
      child: ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (context, index) {
          String noteText = filteredNotes[index]['title'];
          String timestamp =
              _formatTimestamp(filteredNotes[index]['timestamp']);
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0 * _animation.value),
            ),
            child: ListTile(
              title: Text(noteText),
              subtitle: Text(timestamp),
              onTap: () {
                _navigateToNoteDetailScreen(context, noteText);
              },
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
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
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user.uid)
                        .collection('Journal')
                        .doc('Notes')
                        .collection('Title')
                        .doc(newNote)
                        .set({
                      'title': newNote,
                      'timestamp': Timestamp.now(),
                    });
                    setState(() {
                      notes.add(
                          {'title': newNote, 'timestamp': Timestamp.now()});
                      filteredNotes.add(
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

// Add a class for the search functionality

class NotesSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> notes;

  NotesSearch(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for AppBar (e.g., clear query button)
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
      icon: Icon(Icons.arrow_back),
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
