import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/forgot_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late ForgotPassword usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPassword(repo);
  });
  group(
    'forgot_password_test',
    () {
      test(
        'forgot password successfully completes when receiving correct data',
        () async {
          when(() => repo.forgotPassword(any()))
              .thenAnswer((_) async => const Right<ServerFailure, void>(null));

          final result = await usecase.call('');

          expect(result, equals(const Right<dynamic, void>(null)));

          verify(() => repo.forgotPassword('')).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
