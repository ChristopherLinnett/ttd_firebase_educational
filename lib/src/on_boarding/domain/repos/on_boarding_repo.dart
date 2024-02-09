import 'package:ttd_firebase_educational/core/utils/type_defs.dart';

abstract class OnBoardingRepo {
  ResultFuture<void> cachefirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
