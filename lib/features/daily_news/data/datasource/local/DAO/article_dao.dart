import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

@dao
abstract class ArticleDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(ArticleLocalEntity article);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticles(List<ArticleLocalEntity> articles);

  @Query('SELECT * FROM articles')
  Future<List<ArticleLocalEntity>> getArticles();

  @Query('DELETE FROM articles WHERE id = :id')
  Future<void> deleteArticleById(int id);

  @Query('DELETE FROM articles')
  Future<void> deleteAllArticles();

  @delete
  Future<void> deleteArticle(ArticleLocalEntity article);
}
