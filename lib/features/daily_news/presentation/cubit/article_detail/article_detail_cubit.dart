import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_saved_articles_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_save_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/mapper/article_entity_to_local_mapper.dart';

part 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final GetSavedArticlesUseCase getSavedArticlesUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final ArticleEntityToLocalMapper entityToLocalMapper;

  ArticleDetailCubit({
    required this.getSavedArticlesUseCase,
    required this.saveArticleUseCase,
    required this.entityToLocalMapper,
  }) : super(ArticleDetailState.initial());

  Future<void> checkIfArticleIsSaved(String articleUrl) async {
    emit(state.copyWith(isCheckingSaveStatus: true));
    final result = await getSavedArticlesUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isCheckingSaveStatus: false)),
      (articles) {
        final isSaved = articles.any((article) => article.url == articleUrl);
        emit(state.copyWith(isArticleSaved: isSaved, isCheckingSaveStatus: false));
      },
    );
  }

  Future<void> saveArticle(ArticleEntity article) async {
    final localEntity = entityToLocalMapper.map(article);
    await saveArticleUseCase(localEntity);
    emit(state.copyWith(isArticleSaved: true));
  }
}
