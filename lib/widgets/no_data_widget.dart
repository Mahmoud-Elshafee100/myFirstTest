import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
* reusable widget to handling no data
* */
class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          child: Text(
        'No Notes',
        style: TextStyle(color: Colors.black, fontSize: 20.sp),
      )),
    );
  }
}
