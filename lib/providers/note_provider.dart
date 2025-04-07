import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String title, String content) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'userId': uid,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getUserNotes() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _firestore.collection('notes').doc(id).update({
      'title': title,
      'content': content,
    });
  }
}
