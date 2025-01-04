import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

abstract class LocalArticleEvent extends Equatable {
  const LocalArticleEvent();

  @override
  List<Object?> get props => [];
}

class GetSavedArticles extends LocalArticleEvent {
  const GetSavedArticles();

  @override
  List<Object?> get props => [];
}

class SaveArticle extends LocalArticleEvent {
  final ArticleLocalEntity article;

  const SaveArticle(this.article);

  @override
  List<Object?> get props => [article];
}

class RemoveArticle extends LocalArticleEvent {
  final ArticleLocalEntity article;

  const RemoveArticle(this.article);

  @override
  List<Object?> get props => [article];
}
