import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  final DioException? dioError;

  const Failure(this.message, {this.dioError});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(
    super.message, {
    super.dioError,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure(
    super.message, {
    super.dioError,
  });
}
