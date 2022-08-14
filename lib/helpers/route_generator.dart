import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/pages/edit_screen.dart';
import 'package:map_exam/pages/login_screen.dart';

import '../pages/home_screen.dart';

/*
* routing of my app useful for using in large scale apps
* */

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings route) {
    var arguments = route.arguments;

    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case "/homeScreen":
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case "/editScreen":
        Map<String, dynamic> data = arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => EditScreen(
                  editScreenStatus: data['editScreenStatus'],
                  noteData:
                      data.containsKey("noteData") ? data['noteData'] : null,
                ));

      default:
        throw FormatException("Route Is Not Found");
    }
  }
}
