import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;
  const testErrorMessage = 'Insufficient Storage Permissions';

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
      cacheFirstTimer: cacheFirstTimer,
    );
  });
  group(
    'on_boarding_cubit_test',
    () {
      test(
        'initial state should be [OnBoardingInitial]',
        () {
          expect(cubit.state, equals(const OnBoardingInitial()));
        },
      );
      group('cacheFirstTimer', () {
        blocTest<OnBoardingCubit, OnBoardingState>(
          'Should emit [CachingFirstTimer, UserCached] when successful',
          build: () {
            when(() => cacheFirstTimer()).thenAnswer(
              (_) async => const Right(null),
            );
            return cubit;
          },
          act: (cubit) => cubit.cacheFirstTimer(),
          expect: () => const [CachingFirstTimer(), UserCached()],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );

        blocTest<OnBoardingCubit, OnBoardingState>(
          'should emit [CachingFirstTImer, OnBoardingError] when unsuccessful',
          build: () {
            when(() => cacheFirstTimer()).thenAnswer(
              (_) async => Left(
                CacheFailure(message: testErrorMessage, statusCode: 4032),
              ),
            );
            return cubit;
          },
          act: (cubit) => cubit.cacheFirstTimer(),
          expect: () =>
              const [CachingFirstTimer(), OnBoardingError(testErrorMessage)],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );
      });

      group(
        'checkIfUserIsFirstTIme',
        () {
          blocTest<OnBoardingCubit, OnBoardingState>(
            'should emit [CheckingUserIsFirstimer, OnBoardingStatus] when successful',
            build: () {
              when(() => checkIfUserIsFirstTimer()).thenAnswer(
                (_) async => const Right(false),
              );
              return cubit;
            },
            act: (cubit) => cubit.checkIfUserIsFirstTimer(),
            expect: () => const [
              CheckingIfUserIsFirstTimer(),
              OnBoardingStatus(isFirstTimer: false),
            ],
            verify: (_) {
              verify(() => checkIfUserIsFirstTimer()).called(1);
              verifyNoMoreInteractions(checkIfUserIsFirstTimer);
            },
          );

          blocTest<OnBoardingCubit, OnBoardingState>(
            'should emit [CheckingUserIsFirstimer, OnBoardingStatus(true)] when Error occurs',
            build: () {
              when(() => checkIfUserIsFirstTimer()).thenAnswer(
                (_) async => Left(
                  CacheFailure(message: testErrorMessage, statusCode: 4032),
                ),
              );
              return cubit;
            },
            act: (cubit) => cubit.checkIfUserIsFirstTimer(),
            expect: () => [
              const CheckingIfUserIsFirstTimer(),
              const OnBoardingStatus(isFirstTimer: true),
            ],
            verify: (_) {
              verify(() => checkIfUserIsFirstTimer()).called(1);
              verifyNoMoreInteractions(checkIfUserIsFirstTimer);
            },
          );
        },
      );
    },
  );
}
