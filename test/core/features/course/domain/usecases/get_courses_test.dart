import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/repos/course_repo.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/usecases/get_courses.dart';

import 'mock_course_repo.mock.dart';

void main() {
  late CourseRepo repo;
  late GetCourses usecase;

  setUp(() {
    repo = MockCourseRepository();
    usecase = GetCourses(repo);
  });

  group(
    'getCoursesTest',
    () {
      test(
        'should successfully complete with a [List<Course>] when answered with correct data',
        () async {
          when(repo.getCourses).thenAnswer((_) async => const Right([]));
          final result = await usecase();
          expect(
            result,
            equals(
              const Right<dynamic, List<Course>>([]),
            ),
          );
          verify(() => repo.getCourses()).called(1);
          verifyNoMoreInteractions(repo);
        },
      );
    },
  );
}
