import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/datasource/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/datasource/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/mapper/article_model_to_entity_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repo_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/mapper/article_entity_to_local_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/mapper/article_local_to_entity_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_saved_articles_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_save_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_remove_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/remote/remote_article_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerLazySingleton<AppDatabase>(() => database);

  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Register API Service
  final newsApiService = createNewsApiService();
  sl.registerLazySingleton<NewsApiService>(() => newsApiService);

  // Register Mapper
  sl.registerLazySingleton<ArticleModelToEntityMapper>(
    () => ArticleModelToEntityMapper(),
  );

  sl.registerLazySingleton<ArticleEntityToLocalMapper>(
    () => ArticleEntityToLocalMapper(),
  );

  sl.registerLazySingleton<ArticleLocalToEntityMapper>(
    () => ArticleLocalToEntityMapper(),
  );

  // Register Repository
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      appDatabase: sl<AppDatabase>(),
      newsApiService: sl<NewsApiService>(),
      modelToEntityMapper: sl<ArticleModelToEntityMapper>(),
    ),
  );

  // Register UseCases
  sl.registerLazySingleton<GetArticleUseCase>(
    () => GetArticleUseCase(sl<ArticleRepository>()),
  );

  sl.registerLazySingleton<GetSavedArticlesUseCase>(
    () => GetSavedArticlesUseCase(sl<ArticleRepository>()),
  );

  sl.registerLazySingleton<SaveArticleUseCase>(
    () => SaveArticleUseCase(sl<ArticleRepository>()),
  );

  sl.registerLazySingleton<RemoveArticleUseCase>(
    () => RemoveArticleUseCase(sl<ArticleRepository>()),
  );

  // Register Cubits
  sl.registerLazySingleton<RemoteArticlesCubit>(
    () => RemoteArticlesCubit(sl<GetArticleUseCase>()),
  );

  // Register LocalArticleCubit with the necessary use cases
  sl.registerLazySingleton<LocalArticleCubit>(
    () => LocalArticleCubit(
      getSavedArticleUseCase: sl<GetSavedArticlesUseCase>(),
      saveArticleUseCase: sl<SaveArticleUseCase>(),
      removeArticleUseCase: sl<RemoveArticleUseCase>(),
    ),
  );
}