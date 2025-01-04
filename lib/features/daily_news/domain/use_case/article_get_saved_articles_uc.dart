import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repo.dart';

class GetSavedArticlesUseCase
    implements UseCase<List<ArticleLocalEntity>, NoParams> {
  final ArticleRepository _repository;

  GetSavedArticlesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ArticleLocalEntity>>> call(
      NoParams params) async {
    try {
      final articles = await _repository.getSavedArticles();
      return Right(articles);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch saved articles: $e'));
    }
  }
}
