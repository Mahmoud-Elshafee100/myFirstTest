import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_exam/bloc/note_bloc/note_event.dart';
import 'package:map_exam/bloc/note_bloc/note_state.dart';
import 'package:map_exam/models/note.dart';
import 'package:map_exam/repositories/abstract_repo/abstract_note_repo.dart';
import '../../di_locator.dart';
import '../../enums/notes_enums.dart';
import '../../repositories/note_repo.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  /*
  * dependency injection for notes repo
  * */
  final NotesRepository _notesRepository = locator<FirebaseNotesRepository>();
  int lastIndex=-1;

  NotesBloc():super(NotesState()) {
    on<NotesSubscriptionRequested>(_onSubscriptionRequested);
    on<NoteAddingRequested>(_onAdding);
    on<NoteDeletionRequested>(_onDeleted);
    on<NoteUpdatingRequested>(_onUpdating);
    on<ChangeNoteShow>(_onChangeShow);
    on<ChangeNoteEnableTools>(_onChangeEnableTools);
  }
/*
* subsribe for the list of note in the firebase
* */
  Future<void> _onSubscriptionRequested(
      NotesSubscriptionRequested event,
      Emitter<NotesState> emit,
      ) async {
    emit(state.copyWith(status: () => NotesOverviewStatus.loading));

    await emit.forEach<List<Note>>(
      _notesRepository.notes(),
      onData: (notesList) => state.copyWith(
        status: () => NotesOverviewStatus.success,
        notes: () => notesList,
      ),
      onError: (_, __) => state.copyWith(
        status: () => NotesOverviewStatus.failure,
      ),
    );
  }
  /*
  * adding new note event
  * */
  Future<void> _onAdding(
      NoteAddingRequested event,
      Emitter<NotesState> emit,
      ) async {
    await _notesRepository.addNewNote(event.note);
    emit (state.copyWith());
  }
/*
* delete an exist note
* */
  Future<void> _onDeleted(
      NoteDeletionRequested event,
      Emitter<NotesState> emit,
      ) async {
      await _notesRepository.deleteNote(event.note);
      emit (state.copyWith());
  }

  /*
  * update an exist note event
  * */
  Future<void> _onUpdating(
      NoteUpdatingRequested event,
      Emitter<NotesState> emit,
      ) async {
    await _notesRepository.updateNote(event.note);
    emit(state.copyWith());
  }

  /*
  * change the full details show for the items
  * */

  Future<void> _onChangeShow(
      ChangeNoteShow event,
      Emitter<NotesState> emit,
      ) async {
    bool newShow = !state.showFullData;
    emit(state.copyWith(showFullData: newShow));
  }

  /*
  * enable/ disable the tools of an item event
  * */

  Future<void> _onChangeEnableTools(
      ChangeNoteEnableTools event,
      Emitter<NotesState> emit,
      ) async {
    bool newShow = true;
    if(lastIndex != event.index)state.notes.forEach((element) {element.enableTools=false;});
    state.notes[event.index].enableTools=!state.notes[event.index].enableTools;
    lastIndex = event.index;
    emit(state.copyWith(showFullData: newShow));
  }
}