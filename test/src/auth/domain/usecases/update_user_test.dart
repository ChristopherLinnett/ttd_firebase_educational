import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/update_user.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late UpdateUser usecase;
  const params = UpdateUserParams.empty();
  setUp(() {
    repo = MockAuthRepo();
    usecase = UpdateUser(repo);
  });
  group(
    'update_user_test',
    () {
      test(
        'Check that [AuthRepo] is called and completes when [UpdateUser] use case is called',
        () async {
          when(
            () => repo.updateuser(
              action: params.action,
              userData: params.userData,
            ),
          ).thenAnswer((_) async => const Right<ServerFailure, void>(null));

          final result = await usecase.call(params);

          expect(result, equals(const Right<dynamic, void>(null)));
          verify(
            () => repo.updateuser(
              action: params.action,
              userData: params.userData,
            ),
          ).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
