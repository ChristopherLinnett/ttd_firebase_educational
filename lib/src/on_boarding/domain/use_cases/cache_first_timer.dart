import 'package:ttd_firebase_educational/core/usecases/usecases.dart';
import 'package:ttd_firebase_educational/core/utils/type_defs.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  const CacheFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}
