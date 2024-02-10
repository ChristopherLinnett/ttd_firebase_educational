import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';
import 'package:ttd_firebase_educational/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testLocalUserModel = LocalUserModel.empty();

  group(
    'user_model_test',
    () {
      test(
        'Should be a subclass of [LocalUser] entitiy',
        () async {
          expect(testLocalUserModel, isA<LocalUser>());
        },
      );
      final testMap = jsonDecode(fixture('user.json')) as DataMap;
      group('fromMap', () {
        test(
          'Should return a valid [UserModel] from the map',
          () async {
            final result = LocalUserModel.fromMap(testMap);
            expect(result, isA<LocalUserModel>());
            expect(result, equals(testLocalUserModel));
          },
        );
        test(
          'Should throw an [Error]when given invalid map data',
          () async {
            final newMap = {...testMap}..remove('uid');
            const call = LocalUserModel.fromMap;
            expect(() => call(newMap), throwsA(isA<Error>()));
          },
        );
      });
      group('toMap', () {
        test(
          'Should return a valid DataMap with the same Data from the UserModel',
          () async {
            final result = testLocalUserModel.toMap();
            expect(result, isA<DataMap>());
            expect(result, equals(testMap));
          },
        );
      });
      group('copyWith', () {
        test(
          'should return a different [LocalUserModel] when passing a '
          'new uid in [copyWith] method',
          () async {
            final result = testLocalUserModel.copyWith(uid: '105');
            expect(result, isA<LocalUserModel>());
            expect(
              result,
              equals(
                LocalUserModel(
                  uid: '105',
                  email: testLocalUserModel.email,
                  points: testLocalUserModel.points,
                  fullName: testLocalUserModel.fullName,
                ),
              ),
            );
          },
        );
      });
    },
  );
}
