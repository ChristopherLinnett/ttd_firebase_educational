import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/cache_first_timer.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'should call the [OnboardingRepo.cacheFirstTimer] '
    'and return the correct data',
    () async {
      when(() => repo.cachefirstTimer())
          .thenAnswer((_) async => const ReturnSuccess(null));
      final result = await usecase();
      expect(result, equals(const ReturnSuccess(null)));
      verify(() => repo.cachefirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
