import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/repos/course_repo.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/usecases/add_course.dart';

import 'mock_course_repo.mock.dart';

void main() {
  late CourseRepo repo;
  late AddCourse usecase;

  setUp(() {
    repo = MockCourseRepository();
    usecase = AddCourse(repo);
    registerFallbackValue(Course.empty());
  });

  group(
    'AddCourseUseCase',
    () {
      test(
        'should successfully complete when answered with correct data',
        () async {
          when(() => repo.addCourse(any()))
              .thenAnswer((_) async => const Right(null));
          final result = await usecase(Course.empty());
          expect(result, equals(const Right<dynamic, void>(null)));
          verify(() => repo.addCourse(Course.empty())).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
