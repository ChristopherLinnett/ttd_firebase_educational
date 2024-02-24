import 'package:dartz/dartz.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';
import 'package:ttd_firebase_educational/core/features/course/data/datasources/course_remote_datasource.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/repos/course_repo.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

class CourseRepoImplementation implements CourseRepo {
  CourseRepoImplementation(this._remoteDataSource);
  final CourseRemoteDataSource _remoteDataSource;
  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSource.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSource.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
