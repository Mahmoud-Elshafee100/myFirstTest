import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/note_bloc/note_bloc.dart';
import '../../bloc/note_bloc/note_state.dart';

class MainAppBar extends StatelessWidget {

   const MainAppBar({Key? key}) : super(key: key);
   /*
   * appbar of main page screen
   * */
   static AppBar mainAppBar({required String title}){
     return AppBar(
       title:  Text(title,style: TextStyle(color: Colors.white,fontSize: 22.sp),),
       actions: [
         BlocBuilder<NotesBloc, NotesState>(
             builder: (context, notesState) {
             return CircleAvatar(
               backgroundColor: Colors.blue.shade200,
               child: Text(
                 notesState.notes.length.toString(),
                 style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
               ),
             );
           }
         ),
         const SizedBox(
           width: 10,
         ),
       ],
     );
   }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
