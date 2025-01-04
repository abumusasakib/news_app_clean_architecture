import 'package:news_app_clean_architecture/features/daily_news/data/model/article_model.dart';

class JsonToArticleModelMapper {
  ArticleModel map(Map<String, dynamic> json) {
    return ArticleModel.fromJson(json);
  }
}
