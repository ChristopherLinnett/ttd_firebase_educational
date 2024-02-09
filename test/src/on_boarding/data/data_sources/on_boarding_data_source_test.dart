import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_data_source.dart';

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
}
