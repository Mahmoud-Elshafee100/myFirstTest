import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
* reusable widget for loading entire the app
* */
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50.w,
        height: 50.h,
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
