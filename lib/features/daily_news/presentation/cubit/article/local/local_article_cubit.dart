import 'package:bloc/bloc.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_saved_articles_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_remove_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_save_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleCubit({
    required GetSavedArticlesUseCase getSavedArticleUseCase,
    required SaveArticleUseCase saveArticleUseCase,
    required RemoveArticleUseCase removeArticleUseCase,
  })  : _getSavedArticleUseCase = getSavedArticleUseCase,
        _saveArticleUseCase = saveArticleUseCase,
        _removeArticleUseCase = removeArticleUseCase,
        super(const LocalArticlesLoading());

  /// Handles the GetSavedArticles event
  Future<void> onGetSavedArticles() async {
    if (isClosed) return;
    
    try {
      emit(const LocalArticlesLoading());
      final result = await _getSavedArticleUseCase(NoParams());
      
      if (isClosed) return;
      result.fold(
        (failure) => emit(const LocalArticlesDone(articles: [])),
        (articles) => emit(LocalArticlesDone(articles: articles)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(const LocalArticlesDone(articles: []));
    }
  }

  /// Handles the SaveArticle event
  Future<void> onSaveArticle(ArticleLocalEntity article) async {
    if (isClosed) return;
    
    try {
      emit(const LocalArticlesLoading());
      final result = await _saveArticleUseCase(article);
      
      if (isClosed) return;
      result.fold(
        (failure) => emit(const LocalArticlesDone(articles: [])),
        (_) async {
          // Refresh the saved articles after saving
          if (!isClosed) {
            await onGetSavedArticles();
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(const LocalArticlesDone(articles: []));
    }
  }

  /// Handles the RemoveArticle event
  Future<void> onRemoveArticle(ArticleLocalEntity article) async {
    if (isClosed) return;
    
    try {
      emit(const LocalArticlesLoading());
      final result = await _removeArticleUseCase(article);
      
      if (isClosed) return;
      result.fold(
        (failure) => emit(const LocalArticlesDone(articles: [])),
        (_) async {
          // Refresh the saved articles after removal
          if (!isClosed) {
            await onGetSavedArticles();
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(const LocalArticlesDone(articles: []));
    }
  }

  void removeFromState(dynamic article) {
    if (isClosed) return;
    
    if (state is LocalArticlesDone) {
      final currentArticles = (state as LocalArticlesDone).articles!;
      emit(LocalArticlesDone(
        articles: currentArticles.where((a) => a.id != article.id).toList(),
      ));
    }
  }

  void restoreToState(dynamic article) {
    if (isClosed) return;
    
    if (state is LocalArticlesDone) {
      final currentArticles = (state as LocalArticlesDone).articles!;
      emit(LocalArticlesDone(
        articles: [...currentArticles, article],
      ));
    }
  }

  @override
  Future<void> close() async {
    // Clean up any resources here if needed
    await super.close();
  }
}