// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:ttd_firebase_educational/core/usecases/usecases.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';

class SignIn extends UsecaseWithParams<void, SignInParams> {
  const SignIn(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}
