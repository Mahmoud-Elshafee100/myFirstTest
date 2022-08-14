import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_exam/enums/editscreen_action.dart';

import '../../bloc/note_bloc/note_bloc.dart';
import '../../bloc/note_bloc/note_state.dart';

class EditScreenAppbar extends StatelessWidget {

  EditScreenAppbar({Key? key}) : super(key: key);
  /*
  * appbar for editing screen and customized for all status of editing screen add,edit,view
  * */
  static AppBar mainAppBar({required String title,required EditScreenStatus editScreenStatus,required Function() cancel ,Function()? save}) {
    return AppBar(
      leading: Container(),
      centerTitle: true,
      title: Text(title,style: TextStyle(fontSize: 22.sp),),
      actions: [
        if(editScreenStatus != EditScreenStatus.view)IconButton(
            icon: const Icon(
              Icons.check_circle,
              size: 30,
            ),
            onPressed:save ?? (){}),
        IconButton(
            icon: const Icon(
              Icons.cancel_sharp,
              size: 30,
            ),
            onPressed:cancel),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
