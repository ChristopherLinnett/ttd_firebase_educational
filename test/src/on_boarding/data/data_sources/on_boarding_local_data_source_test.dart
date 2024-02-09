import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnboardingLocalDataSourceImplementation(prefs);
  });
  group('cacheFirstTimer', () {
    test(
      'should call [SharedPreferences] to cache the data',
      () async {
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

        await localDataSource.cacheFirstTimer();

        verify(() => prefs.setBool(kFirstTimeKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
        'should throw a [CacheException] when there is a error caching the data',
        () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      final methodCall = localDataSource.cacheFirstTimer;

      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(kFirstTimeKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call the [SharedPreferences] to check if user is a first timer '
        'and return the correct response from storage when data exists',
        () async {
      when(() => prefs.getBool(any())).thenReturn(false);

      final result = await localDataSource.checkIfUserFirstIsFirstTimer();
      expect(result, equals(false));
      verify(() => prefs.getBool(kFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      when(() => prefs.getBool(any())).thenReturn(null);

      final result = await localDataSource.checkIfUserFirstIsFirstTimer();
      expect(result, equals(true));
      verify(() => prefs.getBool(kFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'shoudl throw a [CacheException] when there is an error'
        ' retrieving data', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());

      final methodCall = localDataSource.checkIfUserFirstIsFirstTimer;
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(kFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}
