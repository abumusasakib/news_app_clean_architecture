import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repo.dart';

class GetArticleUseCase implements UseCase<List<ArticleEntity>, NoParams> {
  final ArticleRepository _repository;

  GetArticleUseCase(this._repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) {
    return _repository.getNewsArticles();
  }
}
