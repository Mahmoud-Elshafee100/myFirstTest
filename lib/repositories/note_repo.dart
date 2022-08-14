import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/dto/note_entity.dart';
import 'package:map_exam/models/note.dart';
import 'package:map_exam/repositories/abstract_repo/abstract_note_repo.dart';
/*
* repo class for notes
* */
class FirebaseNotesRepository implements NotesRepository {
  final todoCollection = FirebaseFirestore.instance.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid).collection('notes');
  /*
  * add new note func
  * */
  @override
  Future<void> addNewNote(Note note) {
    return todoCollection.add(note.toEntity().toDocument());
  }
/*
  * delete an note func
  * */
  @override
  Future<void> deleteNote(Note note) {
    return todoCollection.doc(note.id).delete();
  }
/*
  * get all notes func
  * */
  @override
  Stream<List<Note>> notes() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Note.fromEntity(NoteEntity.fromSnapshot(doc)))
          .toList();
    });
  }
/*
  * update an note func
  * */
  @override
  Future<void> updateNote(Note update) {
    return todoCollection
        .doc(update.id.toString())
        .update(update.toEntity().toDocument());
  }

}