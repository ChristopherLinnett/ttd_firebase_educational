import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

abstract class OnBoardingRepo {
  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
