import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

abstract class LocalArticlesState extends Equatable {
  const LocalArticlesState();

  @override
  List<Object?> get props => [];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();

  @override
  List<Object?> get props => [];
}

class LocalArticlesDone extends LocalArticlesState {
  final List<ArticleLocalEntity>? articles;

  const LocalArticlesDone({this.articles});

  @override
  List<Object?> get props => [articles];
}
