import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc/note_bloc.dart';
import '../bloc/note_bloc/note_event.dart';
import '../enums/editscreen_action.dart';
import '../models/note.dart';

/*
* the item of the note
* */

class NoteItem extends StatelessWidget {
  bool showFullData;
  Note noteItem;
  Function(Note item) onTapItem;
  Function(int ind) onLongPressItem;
  int itemIndex;

  NoteItem(
      {Key? key,
      required this.itemIndex,
      required this.noteItem,
      required this.onTapItem,
      required this.onLongPressItem,
      required this.showFullData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showFullData?ListTile(
      trailing: SizedBox(
        width: noteItem.enableTools?110.0:1,
        // height: isShowLess ? 100.h : double.infinity,
        child:noteItem.enableTools? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditScreen(editScreenStatus: EditScreenStatus.edit,noteData: noteItem,)),
                );*/
                Navigator.of(context).pushNamed("/editScreen",arguments: {
                  "editScreenStatus": EditScreenStatus.edit,"noteData": noteItem,
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.blue,
              ),
              onPressed: () {
                BlocProvider.of<NotesBloc>(context).add(NoteDeletionRequested(note:noteItem));
              },
            ),
          ],
        ):const SizedBox(),
      ),
      title:  Text(noteItem.title??""),
      subtitle: Text(noteItem.content??""),
      onTap:()=>onTapItem(noteItem),
      onLongPress:()=>onLongPressItem(itemIndex),
    ) :ListTile(
      title:  Text(noteItem.title??""),
      onTap:()=>onTapItem(noteItem),
      onLongPress:()=>onLongPressItem(itemIndex),
    );
  }
}
