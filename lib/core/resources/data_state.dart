import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState();

  factory DataState.initial() = DataInitial<T>;

  factory DataState.loading() = DataLoading<T>;

  factory DataState.success(T data) = DataSuccess<T>;

  factory DataState.failure(DioException error) = DataFailure<T>;

  /// `when` method provides a structured way to handle states.
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(DioException error) failure,
  }) {
    if (this is DataInitial<T>) {
      return initial();
    } else if (this is DataLoading<T>) {
      return loading();
    } else if (this is DataSuccess<T>) {
      return success((this as DataSuccess<T>).data);
    } else if (this is DataFailure<T>) {
      return failure((this as DataFailure<T>).error);
    } else {
      throw Exception('Unhandled DataState type');
    }
  }
}

class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

class DataLoading<T> extends DataState<T> {
  const DataLoading();
}

class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess(this.data);
}

class DataFailure<T> extends DataState<T> {
  final DioException error;

  const DataFailure(this.error);
}
