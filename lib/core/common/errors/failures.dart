import 'package:equatable/equatable.dart';
import 'package:ttd_firebase_educational/core/common/errors/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is int || statusCode is String,
          '${statusCode.runtimeType} is not valid for a statusCode, '
          'use a String or integer only',
        );
  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode ' 'Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
