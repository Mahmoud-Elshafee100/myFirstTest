import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_exam/bloc/note_bloc/note_bloc.dart';
import 'package:map_exam/bloc/note_bloc/note_state.dart';
import 'package:map_exam/enums/editscreen_action.dart';
import 'package:map_exam/enums/notes_enums.dart';
import 'package:map_exam/models/note.dart';
import 'package:map_exam/widgets/appbar/main_appbar.dart';
import 'package:map_exam/widgets/loading_widget.dart';
import 'package:map_exam/widgets/no_data_widget.dart';
import 'package:map_exam/widgets/note_item.dart';
import '../bloc/note_bloc/note_event.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotesBloc>(context).add(const NotesSubscriptionRequested());
  }

  /*
  * navigate and show the details for the items
  * */
  void onTapItem(Note item){
    Navigator.of(context).pushNamed("/editScreen",arguments: {
      "editScreenStatus": EditScreenStatus.view,"noteData": item,
    });
  }

  /*
  * appear and disapear tools for every item on long press
  * */
  void onLongPressItem(int index){
    BlocProvider.of<NotesBloc>(context).add(ChangeNoteEnableTools(index: index));
  }

  /*
  * change full details mode for all the items
  * */
  void changeShowLess(){
    BlocProvider.of<NotesBloc>(context).add(ChangeNoteShow());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.mainAppBar(title: "My Notes"),
      body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, notesState) {
            if(notesState.status == NotesOverviewStatus.loading){
              return const LoadingWidget();
            }
          return notesState.notes.isNotEmpty? Padding(
            padding:EdgeInsets.symmetric(vertical: 8.0.h),
            child: ListView.separated(
              itemCount: notesState.notes.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.blueGrey,
              ),
                  itemBuilder: (context, index) => NoteItem(
                      itemIndex: index,
                      noteItem: notesState.notes[index],
                      showFullData: notesState.showFullData,
                      onTapItem: onTapItem,
                      onLongPressItem: onLongPressItem),
                ),
          ) : const NoData();
        }
      ),
      floatingActionButton: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, notesState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*
              * action button for appear and disapear the full details
              * */
              FloatingActionButton(
                  heroTag: "tag1",
                  child: notesState.showFullData?Stack(
                    children: [
                      Align(alignment:Alignment.center,child: Container(margin:EdgeInsets.only(bottom: 12.h),child: Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 22.sp,))),
                      Align(alignment:Alignment.center,child:Container(margin:EdgeInsets.only(top: 12.h),child: Icon(Icons.keyboard_arrow_up,color: Colors.white,size: 22.sp,))),
                    ],
                  ) : Icon(Icons.menu,color: Colors.white,size: 22.sp,),
                  tooltip: 'Show less. Hide notes content',
                  onPressed: changeShowLess),

              /* Notes: for the "Show More" icon use: Icons.menu */

              /*
              * action button for adding new note
              * */

              FloatingActionButton(
                heroTag: "tag2",
                child: const Icon(Icons.add),
                tooltip: 'Add a new note',
                onPressed: () {
                  Navigator.of(context).pushNamed("/editScreen",arguments: {
                    "editScreenStatus": EditScreenStatus.add
                  });
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
