import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repo.dart';

class SaveArticleUseCase implements UseCase<void, ArticleLocalEntity> {
  final ArticleRepository _repository;

  SaveArticleUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ArticleLocalEntity params) async {
    try {
      await _repository.saveArticle(params);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('Failed to save article: $e'));
    }
  }
}
