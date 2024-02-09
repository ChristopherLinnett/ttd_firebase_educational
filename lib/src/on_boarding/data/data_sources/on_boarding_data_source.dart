import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserFirstIsFirstTimer();
}

const kFirstTimeKey = 'first_time_opened';

class OnboardingLocalDataSourceImplementation
    implements OnBoardingLocalDataSource {
  OnboardingLocalDataSourceImplementation(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimeKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserFirstIsFirstTimer() {
    // TODO: implement checkIfUserFirstIsFirstTimer
    throw UnimplementedError();
  }
}
