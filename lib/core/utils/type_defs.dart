import 'package:dartz/dartz.dart';
import 'package:ttd_firebase_educational/core/common/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

typedef ReturnFail<T> = Left<Failure, T>;
typedef ReturnSuccess<T> = Right<Failure, T>;
