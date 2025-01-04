import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';

abstract class RemoteArticlesState extends Equatable {
  const RemoteArticlesState();

  @override
  List<Object?> get props => [];
}

class ArticlesLoading extends RemoteArticlesState {
  const ArticlesLoading();
}

class ArticlesDone extends RemoteArticlesState {
  final List<ArticleEntity> articles;

  const ArticlesDone(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticlesError extends RemoteArticlesState {
  final DioException error;

  const ArticlesError(this.error);

  @override
  List<Object?> get props => [error];
}
