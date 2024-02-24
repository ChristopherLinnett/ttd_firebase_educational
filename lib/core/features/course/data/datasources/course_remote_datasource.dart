import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<List<Course>> getCourses();

  Future<void> addCourse(Course course);
}
