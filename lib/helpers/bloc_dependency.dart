
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_exam/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:map_exam/bloc/note_bloc/note_bloc.dart';
/*
* repo provider for the bloc
* */
List<RepositoryProvider> buildRepositories() {
  return [
    RepositoryProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
    RepositoryProvider<NotesBloc>(create: (_) => NotesBloc()),
  ];
}