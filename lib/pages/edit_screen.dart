import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_exam/models/note.dart';

import '../bloc/note_bloc/note_bloc.dart';
import '../bloc/note_bloc/note_event.dart';
import '../enums/editscreen_action.dart';
import '../widgets/appbar/editscreen_appbar.dart';

class EditScreen extends StatefulWidget {
  EditScreenStatus editScreenStatus;  //to know what want to do in the screen add,view or edit
  Note? noteData; // the date of item if edit or view the item

  EditScreen({Key? key, required this.editScreenStatus, this.noteData})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String appBarTitle = "";
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.editScreenStatus) {
      case EditScreenStatus.add:
        appBarTitle = "Add New Note";
        break;
      case EditScreenStatus.view:
        appBarTitle = "View Note";
        _titleController.text = widget.noteData!.title!;
        _descriptionController.text = widget.noteData!.content!;
        break;
      case EditScreenStatus.edit:
        appBarTitle = "Edit Note";
        _titleController.text = widget.noteData!.title!;
        _descriptionController.text = widget.noteData!.content!;
        break;
    }
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void save() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      if (widget.editScreenStatus == EditScreenStatus.edit) {
        BlocProvider.of<NotesBloc>(context).add(NoteUpdatingRequested(
            note: Note(
          id: widget.noteData!.id,
          title: _titleController.text.toString(),
          content: _descriptionController.text.toString(),
        )));
      } else if (widget.editScreenStatus == EditScreenStatus.add) {
        BlocProvider.of<NotesBloc>(context).add(NoteAddingRequested(
            note: Note(
          title: _titleController.text.toString(),
          content: _descriptionController.text.toString(),
        )));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditScreenAppbar.mainAppBar(
          title: appBarTitle,
          save: save,
          editScreenStatus: widget.editScreenStatus,
          cancel: cancel),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              enabled: (widget.editScreenStatus == EditScreenStatus.view)
                  ? false
                  : true,
              decoration: (widget.editScreenStatus == EditScreenStatus.view)?const InputDecoration(
                border:InputBorder.none,
                hintText: 'Type the title here',
              ):const InputDecoration(hintText: 'Type the title here',) ,
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                  controller: _descriptionController,
                  enabled: (widget.editScreenStatus == EditScreenStatus.view)
                      ? false
                      : true,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type the description',
                  ),
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
