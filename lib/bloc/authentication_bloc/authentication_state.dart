import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/enums/auth_enums.dart';

class AuthState {
   AuthState({
    this.authOverviewStatus = AuthOverviewStatus.initial,
    this.userCredential ,
  });

   AuthOverviewStatus authOverviewStatus;
  final UserCredential? userCredential;

   AuthState copyWith({
     AuthOverviewStatus? authOverviewStatus,
     final UserCredential? userCredential,
  }) {
    return AuthState(
      authOverviewStatus: authOverviewStatus ?? this.authOverviewStatus,
      userCredential: userCredential ?? this.userCredential,
    );
  }
}