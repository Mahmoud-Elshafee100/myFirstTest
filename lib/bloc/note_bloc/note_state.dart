import 'package:map_exam/models/note.dart';
import '../../enums/notes_enums.dart';



class NotesState {
   NotesState({
    this.status = NotesOverviewStatus.initial,
    this.notes = const [],
    this.showFullData=false,
  });

  final NotesOverviewStatus status;
  final List<Note> notes;
  bool showFullData;

  NotesState copyWith({
    NotesOverviewStatus Function()? status,
    List<Note> Function()? notes,
    bool? showFullData,
  }) {
    return NotesState(
      status: status != null ? status() : this.status,
      notes: notes != null ? notes() : this.notes,
      showFullData: showFullData ?? this.showFullData,
    );
  }

  @override
  List<Object?> get props => [
    status,
    notes,
  ];
}