part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent(
      {required this.email, required this.password, required this.fullName,});
  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password, fullName];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({required this.email});
  final String email;

  @override
  List<String> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({required this.action, required this.userData})
      : assert(
          userData is File || userData is String,
          '[userData] must be a string or file, but was ${userData.runtimeType}',
        );
  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
