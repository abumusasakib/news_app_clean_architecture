import 'package:news_app_clean_architecture/features/daily_news/data/model/article_model.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';

class ArticleMapper {
  // Convert Freezed ArticleModel to Floor ArticleLocalEntity
  static ArticleLocalEntity toEntity(ArticleModel model) {
    return ArticleLocalEntity(
      sourceId: model.source.id ?? '',
      sourceName: model.source.name,
      author: model.author ?? '',
      title: model.title,
      description: model.description ?? '',
      url: model.url,
      urlToImage: model.urlToImage ?? '',
      publishedAt: model.publishedAt,
      content: model.content ?? '',
    );
  }

  // Convert Floor ArticleLocalEntity to Freezed ArticleModel
  static ArticleModel toModel(ArticleLocalEntity entity) {
    return ArticleModel(
      source: ArticleSourceModel(id: entity.sourceId, name: entity.sourceName),
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
