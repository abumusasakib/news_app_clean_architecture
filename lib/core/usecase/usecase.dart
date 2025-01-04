import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';

/// Abstract class representing a use case.
///
/// [Type] is the expected result type.
/// [Params] is the type of the input parameters.
abstract class UseCase<Type, Params> {
  /// Method to be implemented by concrete use cases.
  Future<Either<Failure, Type>> call(Params params);
}

/// Helper class for use cases that don't require parameters.
class NoParams {
  const NoParams();
}
