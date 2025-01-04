import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_uc.dart';

class RemoteArticlesCubit extends Cubit<DataState<List<ArticleEntity>>> {
  final GetArticleUseCase _getNewsArticlesUseCase;

  RemoteArticlesCubit(this._getNewsArticlesUseCase)
      : super(const DataInitial());

  Future<void> fetchArticles() async {
    emit(const DataLoading());

    final result = await _getNewsArticlesUseCase.call(NoParams());

    result.fold(
      (failure) => emit(DataFailure(DioException(
        requestOptions: RequestOptions(path: ''),
        error: failure.message,
      ))),
      (articles) => emit(DataSuccess(articles)),
    );
  }
}
