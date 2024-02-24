import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();
  ResultFuture<void> addCourse(Course course);
  
}
