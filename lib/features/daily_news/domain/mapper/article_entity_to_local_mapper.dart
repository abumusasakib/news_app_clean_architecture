import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

class ArticleEntityToLocalMapper {
  ArticleLocalEntity map(ArticleEntity entity) {
    return ArticleLocalEntity(
      id: null, // ID is auto-generated when saving to the database
      sourceId: entity.source.id ?? '',
      sourceName: entity.source.name ?? '',
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }
}
