import 'package:news_app_clean_architecture/features/daily_news/data/model/article_model.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';

class ArticleModelToEntityMapper {
  ArticleEntity map(ArticleModel model) {
    return ArticleEntity(
      source: ArticleSource(
        id: model.source.id,
        name: model.source.name,
      ),
      author: model.author ?? '',
      title: model.title,
      description: model.description ?? '',
      url: model.url,
      urlToImage: model.urlToImage ?? '',
      publishedAt: model.publishedAt,
      content: model.content ?? '',
    );
  }
}
