import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ttd_firebase_educational/core/features/course/data/model/course_model.dart';
import 'package:ttd_firebase_educational/core/features/course/domain/entities/course.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final testCourseModel = CourseModel.empty();
  final testMap = jsonDecode(fixture('course.json')) as DataMap;
  final timestampData = {
    '_seconds': 1643125523,
    '_nanoseconds': 123000000,
  };
  final timestamp =
      Timestamp(timestampData['_seconds']!, timestampData['_nanoseconds']!);
  testMap['createdAt'] = timestamp;
  testMap['updatedAt'] = timestamp;
  group('empty', () {
    test(
      'should successfully return an empty [Course] with the given inputs ',
      () {
        final result = CourseModel.empty();
        expect(result.title, equals(''));
      },
    );
  });
  group(
    'CourseModel',
    () {
      test(
        'should be a subclass of [Course] entity',
        () {
          expect(testCourseModel, isA<Course>());
        },
      );
    },
  );
  group('copyWith', () {
    test(
      'should return a [CourseModel] identical to the given [CourseModel] with one updated property',
      () {
        final result = testCourseModel.copyWith(numberOfExams: 100);
        expect(result, isA<CourseModel>());
        expect(result, equals(testCourseModel));
        expect(result.numberOfExams, 100);
      },
    );
  });

  group('fromMap', () {
    test(
      'should return a [CourseModel] with the same properties as the given [DataMap]',
      () {
        final result = CourseModel.fromMap(testMap);
        expect(result, isA<CourseModel>());
        expect(result, equals(testCourseModel));
      },
    );
  });
  group('toMap', () {
    test(
      'should return a [DataMap] with the same properties as the given [CourseModel]',
      () {
        final result = testCourseModel.toMap()
          ..remove('createdAt')
          ..remove('updatedAt');
        final outputMap = testMap
          ..remove('createdAt')
          ..remove('updatedAt');
        expect(result, isA<DataMap>());
        expect(result, equals(outputMap));
      },
    );
  });
}
