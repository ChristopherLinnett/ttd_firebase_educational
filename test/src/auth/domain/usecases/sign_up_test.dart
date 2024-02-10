import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_up.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignUp usecase;
  const params = SignUpParams.empty();
  setUp(() {
    repo = MockAuthRepo();
    usecase = SignUp(repo);
  });
  group(
    'sign_up_test',
    () {
      test(
        'calling [SignUp] use case will call AuthRepo signUp function '
        'and complete successfully',
        () async {
          when(
            () => repo.signUp(
              email: params.email,
              fullName: params.fullName,
              password: params.password,
            ),
          ).thenAnswer((_) async => const Right<ServerFailure, void>(null));

          final result = await usecase.call(params);

          expect(result, equals(const Right<dynamic, void>(null)));
          verify(
            () => repo.signUp(
              email: params.email,
              password: params.password,
              fullName: params.fullName,
            ),
          ).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
