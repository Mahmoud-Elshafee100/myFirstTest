import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'di_locator.dart';
import 'helpers/bloc_dependency.dart';
import 'helpers/route_generator.dart';
import 'pages/login_screen.dart';

void main()async {
  /*
  * firebase
  * */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*
  * dependency injection
  * */
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( //use it to handle responsive design
        designSize: const Size(375, 812),
        builder: (context, child) => MultiRepositoryProvider(
            providers: buildRepositories(), //building the bloc repo
            child: MaterialApp(
              title: 'myFirst',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: RouteGenerator.generateRoute, //generting the rout
              home: const LoginScreen(),)));
  }
}
