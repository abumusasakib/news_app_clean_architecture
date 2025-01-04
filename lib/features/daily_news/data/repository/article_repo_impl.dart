import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/environment/environment.dart';
import 'package:news_app_clean_architecture/core/error/failure.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/datasource/local/app_database.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/datasource/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/mapper/article_model_to_entity_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/model/article_model.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repo.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  final ArticleModelToEntityMapper _modelToEntityMapper;

  ArticleRepositoryImpl({
    required NewsApiService newsApiService,
    required AppDatabase appDatabase,
    required ArticleModelToEntityMapper modelToEntityMapper,
  })  : _newsApiService = newsApiService,
        _appDatabase = appDatabase,
        _modelToEntityMapper = modelToEntityMapper;

  /// Fetches news articles from the API
  @override
  Future<Either<Failure, List<ArticleEntity>>> getNewsArticles() async {
    try {
      // Fetch data using NewsApiService
      final response = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        // Access the articles field
        final articlesJson = response.data['articles'] as List<dynamic>;

        // Map articles to entities
        final articleEntities = articlesJson
            .map(
                (json) => _modelToEntityMapper.map(ArticleModel.fromJson(json)))
            .toList();

        return Right(articleEntities);
      } else {
        return Left(ServerFailure(
          'Unexpected status code: ${response.response.statusCode}',
        ));
      }
    } on DioException catch (dioError) {
      return Left(
        ServerFailure(dioError.message ?? "Unknown error", dioError: dioError),
      );
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: $e'));
    }
  }

  /// Fetches saved articles from the local database
  @override
  Future<List<ArticleLocalEntity>> getSavedArticles() async {
    try {
      return await _appDatabase.articleDAO.getArticles();
    } catch (e) {
      throw Exception('Failed to fetch saved articles: $e');
    }
  }

  /// Saves an article to the local database
  @override
  Future<void> saveArticle(ArticleLocalEntity article) async {
    try {
      await _appDatabase.articleDAO.insertArticle(article);
    } catch (e) {
      throw Exception('Failed to save article: $e');
    }
  }

  /// Removes an article from the local database
  @override
  Future<void> removeArticle(ArticleLocalEntity article) async {
    try {
      await _appDatabase.articleDAO.deleteArticle(article);
    } catch (e) {
      throw Exception('Failed to remove article: $e');
    }
  }
}
