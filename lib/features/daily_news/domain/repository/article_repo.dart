import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

abstract class ArticleRepository {
  // API methods
  /// Fetches a list of articles from a data source.
  /// Returns an [Either] with a [Failure] on the left side or a list of [ArticleEntity] on the right side.
  Future<Either<Failure, List<ArticleEntity>>> getNewsArticles();

  // Database methods
  Future<List<ArticleLocalEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleLocalEntity article);
  
  Future<void> removeArticle(ArticleLocalEntity article);
}
