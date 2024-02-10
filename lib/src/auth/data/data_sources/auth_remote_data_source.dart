import 'package:ttd_firebase_educational/core/enums/update_user.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<void> forgotPassword({required String email});

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<LocalUserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({required UpdateUserAction action, required dynamic userData});
}
