import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_exam/bloc/authentication_bloc/authentication_event.dart';
import 'package:map_exam/bloc/authentication_bloc/authentication_state.dart';
import 'package:map_exam/enums/auth_enums.dart';
import 'package:map_exam/repositories/abstract_repo/abstract_auth_repo.dart';
import '../../di_locator.dart';
import '../../repositories/auth_repo.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {

  /*dependency injection for auth repo*/

  final AuthRepository _authRepository = locator<FirebaseAuthenticationRepository>();

  AuthenticationBloc():super(AuthState()) {
    on<SignInRequest>(_onSignInRequested);
    on<SignOutRequest>(_onSignOutRequested);
  }
/*
* sign in event
* */
  Future<void> _onSignInRequested(
      SignInRequest event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(authOverviewStatus: AuthOverviewStatus.loading));
    UserCredential? userCredential = await _authRepository.signIn(email: event.email, password: event.password);
    //log("uuuuu===> $userCredential");
    if(userCredential != null){
      emit (state.copyWith(userCredential: userCredential,authOverviewStatus: AuthOverviewStatus.success));
    }else{
      emit (state.copyWith(userCredential: userCredential,authOverviewStatus: AuthOverviewStatus.failure));
    }

  }
/*
* sign out event
* */
  Future<void> _onSignOutRequested(
      SignOutRequest event,
      Emitter<AuthState> emit,
      ) async {
    await _authRepository.signOut();
    emit (state.copyWith());
  }

}