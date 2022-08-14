
import 'package:map_exam/models/note.dart';

abstract class NotesEvent  {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesSubscriptionRequested extends NotesEvent {
  const NotesSubscriptionRequested();
}

class NoteAddingRequested extends NotesEvent {
  Note note;
  NoteAddingRequested({required this.note});
}

class NoteDeletionRequested extends NotesEvent {
  Note note;
  NoteDeletionRequested({required this.note});
}

class NoteUpdatingRequested extends NotesEvent {
  Note note;
   NoteUpdatingRequested({required this.note});
}

class ChangeNoteShow extends NotesEvent {
  ChangeNoteShow();
}
class ChangeNoteEnableTools extends NotesEvent {
  int index;
  ChangeNoteEnableTools({required this.index});
}