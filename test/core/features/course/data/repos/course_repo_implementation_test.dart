import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/core/features/course/data/datasources/course_remote_datasource.dart';
import 'package:ttd_firebase_educational/core/features/course/data/model/course_model.dart';
import 'package:ttd_firebase_educational/core/features/course/data/repos/course_repo_implementation.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';

class MockCourseRemoteDataSource extends Mock
    implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late CourseRepoImplementation repoImplementation;

  final testCourse = CourseModel.empty();

  setUp(() {
    remoteDataSource = MockCourseRemoteDataSource();
    repoImplementation = CourseRepoImplementation(remoteDataSource);
    registerFallbackValue(testCourse);
  });

  const testException =
      ServerException(message: 'Something went wrong', statusCode: '500');
  group(
    'course_repo_implementation_tests',
    () {
      group('getCourses', () {
        test(
          'should return a [List<Course>] when successfully fetching data',
          () async {
            when(remoteDataSource.getCourses)
                .thenAnswer((_) async => [testCourse]);
            final result = await repoImplementation.getCourses();

            expect(
              result,
              isA<Right<dynamic, List<Course>>>(),
            );
            verify(remoteDataSource.getCourses).called(1);
            verifyNoMoreInteractions(remoteDataSource);
          },
        );
        test(
          'should return a [ServerFailure] with correct message and code when unsuccessful',
          () async {
            when(remoteDataSource.getCourses).thenThrow(testException);
            final result = await repoImplementation.getCourses();
            expect(
              result,
              equals(
                Left<Failure, dynamic>(
                  ServerFailure(
                    message: testException.message,
                    statusCode: testException.statusCode,
                  ),
                ),
              ),
            );
            verify(remoteDataSource.getCourses).called(1);
            verifyNoMoreInteractions(remoteDataSource);
          },
        );
      });
      group('addCourse', () {
        test(
          'should complete successfully when call to remote data source is successful',
          () async {
            when(
              () => remoteDataSource.addCourse(any()),
            ).thenAnswer((_) async => Future.value());
            final result = await repoImplementation.addCourse(testCourse);
            expect(result, equals(const Right<dynamic, void>(null)));
            verify(() => remoteDataSource.addCourse(CourseModel.empty()))
                .called(1);
            verifyNoMoreInteractions(remoteDataSource);
          },
        );
        test(
          'should return [ServerFailure] with correct message when call to remote data source fails',
          () async {
            when(
              () => remoteDataSource.addCourse(any()),
            ).thenThrow(testException);
            final result = await repoImplementation.addCourse(testCourse);
            expect(
              result,
              equals(
                Left<ServerFailure, void>(
                  ServerFailure(
                    message: testException.message,
                    statusCode: testException.statusCode,
                  ),
                ),
              ),
            );
            verify(() => remoteDataSource.addCourse(CourseModel.empty()))
                .called(1);
            verifyNoMoreInteractions(remoteDataSource);
          },
        );
      });
    },
  );
}
