import 'package:map_exam/dto/note_entity.dart';
/*
* this is the model of the note which i use in the app
* */
class Note {
  final dynamic id;
  String? title;
  String? content;
  bool enableTools;
  Note({this.id = 0, this.title = '', this.content = '',this.enableTools=false});

  NoteEntity toEntity() {
    return NoteEntity( id:id,title: title,content: content);
  }

  static Note fromEntity(NoteEntity entity) {
    return Note(
      id: entity.id,
      title: entity.title,
      content: entity.content,
    );
  }
}
