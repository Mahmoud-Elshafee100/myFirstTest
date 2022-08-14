import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_exam/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:map_exam/bloc/authentication_bloc/authentication_state.dart';
import 'package:map_exam/enums/auth_enums.dart';
import 'package:map_exam/pages/home_screen.dart';
import 'package:map_exam/widgets/loading_widget.dart';

import '../bloc/authentication_bloc/authentication_event.dart';

class LoginScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIn()
  {
    if(_usernameController.text.isNotEmpty&&_passwordController.text.isNotEmpty){
      BlocProvider.of<AuthenticationBloc>(context).add(SignInRequest(
          email: _usernameController.text.toString(),
          password: _passwordController.text.toString(),
      ));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: BlocConsumer<AuthenticationBloc, AuthState>(
            listener:(context, authState) {
              if(authState.authOverviewStatus== AuthOverviewStatus.success){
                Navigator.of(context).pushReplacementNamed("/homeScreen");
              }
              if (authState.authOverviewStatus == AuthOverviewStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("invalid username or password")));
            }
          },
            builder: (context, authState) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Please sign in', style: TextStyle(fontSize: 35.0)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration:
                        const InputDecoration(hintText: 'Type your email here'),
                    onTap: () {},
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Type your password',
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 10.0),
                  authState.authOverviewStatus== AuthOverviewStatus.loading ?
                      const LoadingWidget()
                      :ElevatedButton(child: const Text('Sign in'), onPressed: signIn ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
