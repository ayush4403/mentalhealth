import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionData {
  final List<int> sessionTimers;

  SessionData({
    required this.sessionTimers,
  });
  final User? user = FirebaseAuth.instance.currentUser;
  factory SessionData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SessionData(
      sessionTimers: List<int>.from(data['week1'] ?? []),
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Future<List<SessionData>> getSessionData(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('MeditationData')
          .get();

      return snapshot.docs
          .map((doc) => SessionData.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching session data: $e');
      return [];
    }
  }
}
