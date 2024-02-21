part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
}

Future<void> _onBoardingInit() async {
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

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImplementation(remoteDataSource: sl()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(
        authClient: sl(),
        dbClient: sl(),
        cloudStoreClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
