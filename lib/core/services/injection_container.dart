import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/repos/on_boarding_repo_implementation.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  /// Feature ---> onBoarding
  /// Business Logic
  sl
    ..registerFactory(
      () =>
          OnBoardingCubit(checkIfUserIsFirstTimer: sl(), cacheFirstTimer: sl()),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImplementation(sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnboardingLocalDataSourceImplementation(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
