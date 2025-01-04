import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

class ArticleLocalToEntityMapper {
  ArticleEntity map(ArticleLocalEntity localEntity) {
    return ArticleEntity(
      source: ArticleSource(
        id: localEntity.sourceId,
        name: localEntity.sourceName,
      ),
      author: localEntity.author ?? '',
      title: localEntity.title,
      description: localEntity.description ?? '',
      url: localEntity.url,
      urlToImage: localEntity.urlToImage ?? '',
      publishedAt: localEntity.publishedAt,
      content: localEntity.content ?? '',
    );
  }
}
