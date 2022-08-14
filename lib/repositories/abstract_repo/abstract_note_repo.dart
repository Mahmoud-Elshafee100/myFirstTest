import 'package:map_exam/models/note.dart';

abstract class NotesRepository {
  Future<void> addNewNote(Note note);

  Future<void> deleteNote(Note note);

  Stream<List<Note>> notes();

  Future<void> updateNote(Note note);
}