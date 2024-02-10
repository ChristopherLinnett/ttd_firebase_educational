import 'package:ttd_firebase_educational/core/enums/update_user.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateuser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
