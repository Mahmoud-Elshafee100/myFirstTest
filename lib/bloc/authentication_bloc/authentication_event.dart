
abstract class AuthEvent  {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequest extends AuthEvent {
  String email;
  String password;
  SignInRequest({required this.email, required this.password});
}

class SignOutRequest extends AuthEvent {
  SignOutRequest();
}
