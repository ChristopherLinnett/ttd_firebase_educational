import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_in.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignIn usecase;
  const signInParams = SignInParams.empty();
  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });
  group(
    'sign_in_test',
    () {
      test(
        'Repo should return an empty [LocalUser] when signIn called with empty signInParams',
        () async {
          when(
            () => repo.signIn(
              email: signInParams.email,
              password: signInParams.password,
            ),
          ).thenAnswer((_) async => const Right(LocalUser.empty()));

          final result = await usecase.call(const SignInParams.empty());

          expect(
            result,
            equals(const Right<dynamic, LocalUser>(LocalUser.empty())),
          );
          verify(
            () => repo.signIn(
              email: signInParams.email,
              password: signInParams.password,
            ),
          ).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
