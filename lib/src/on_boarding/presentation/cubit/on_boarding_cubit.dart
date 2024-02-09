import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
    required CacheFirstTimer cacheFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();
    result.fold(
      (failure) => emit(OnBoardingError(failure.message)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimer();
    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
