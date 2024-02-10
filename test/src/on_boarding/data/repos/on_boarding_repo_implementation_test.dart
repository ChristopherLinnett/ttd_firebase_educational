import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/repos/on_boarding_repo_implementation.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImplementation repoImplementation;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repoImplementation = OnBoardingRepoImplementation(localDataSource);
  });
  group(
    'on_boarding_repo_implementation_test',
    () {
      test(
        'should be a subclass of [OnBoardingRepo]',
        () async {
          expect(repoImplementation, isA<OnBoardingRepo>());
        },
      );
      group('cacheFirstTimer', () {
        test(
            'should complete successfully when call to local source is successful',
            () async {
          when(() => localDataSource.cacheFirstTimer())
              .thenAnswer((_) async => Future.value());

          final result = await repoImplementation.cacheFirstTimer();

          expect(result, equals(const Right<dynamic, void>(null)));

          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        });

        test(
            'should return [CacheFailure] when call to local source is'
            ' unsuccessful', () async {
          when(() => localDataSource.cacheFirstTimer())
              .thenThrow(const CacheException(message: 'Insufficient Storage'));

          final result = await repoImplementation.cacheFirstTimer();

          expect(
            result,
            equals(
              Left<CacheFailure, dynamic>(
                CacheFailure(
                  message: 'Insufficient Storage',
                  statusCode: 500,
                ),
              ),
            ),
          );
          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        });
      });

      group('checkIfUserIsFirstTimer', () {
        final values = [true, false];
        for (final value in values) {
          test(
              'should future result with $value when data source returns $value',
              () async {
            when(() => localDataSource.checkIfUserFirstIsFirstTimer())
                .thenAnswer((_) async => Future.value(value));

            final result = await repoImplementation.checkIfUserIsFirstTimer();

            expect(result, equals(Right<dynamic, bool>(value)));
            verify(() => localDataSource.checkIfUserFirstIsFirstTimer())
                .called(1);
            verifyNoMoreInteractions(localDataSource);
          });
        }
        test('should throw [CacheError] when data source throws error',
            () async {
          when(() => localDataSource.checkIfUserFirstIsFirstTimer())
              .thenThrow(const CacheException(message: 'Permission Error'));

          final result = await repoImplementation.checkIfUserIsFirstTimer();

          expect(
            result,
            equals(
              Left<CacheFailure, dynamic>(
                CacheFailure(message: 'Permission Error', statusCode: 500),
              ),
            ),
          );
          verify(() => localDataSource.checkIfUserFirstIsFirstTimer())
              .called(1);
          verifyNoMoreInteractions(localDataSource);
        });
      });
    },
  );
}
