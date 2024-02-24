import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/repos/course_repo.dart';
import 'package:ttd_firebase_educational/core/usecases/usecases.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

class GetCourses extends UseCaseWithoutParams<List<Course>> {
  const GetCourses(this._repo);
  final CourseRepo _repo;

  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();
}
