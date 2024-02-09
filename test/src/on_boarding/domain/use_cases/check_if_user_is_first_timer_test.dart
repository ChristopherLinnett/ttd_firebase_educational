import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/core/usecases/usecases.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';

import 'on_boarding_repo.mock.dart';

Future<void> main() async {
  late OnBoardingRepo repo;
  late UseCaseWithoutParams<bool> usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });
  test('should return [True] if user first time opening app', () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));
    final result = await usecase();
    expect(result, equals(const Right<Failure, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
