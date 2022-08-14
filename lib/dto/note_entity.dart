import 'package:cloud_firestore/cloud_firestore.dart';
/*
* dto class for the note that contain the data of the note in db and use it when get or send data to server
* but model use it in my code entire the app
* */
class NoteEntity {
  final dynamic id;
  String? title;
  String? content;

  NoteEntity({this.id = 0, this.title = '', this.content = ''});


  NoteEntity.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], title: json['title'], content: json['content']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};

  static NoteEntity fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data =
    snap.data()! as Map<String, dynamic>;
    return NoteEntity(
      id:snap.id,
      title:data['title'],
      content:data['content'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'title': title??"",
      'content': content??"",
    };
  }
}