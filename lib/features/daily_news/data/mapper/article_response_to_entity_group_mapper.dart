import 'package:news_app_clean_architecture/features/daily_news/data/mapper/article_json_to_model_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/mapper/article_model_to_entity_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';

class ResponseToEntityGroupMapper {
  final JsonToArticleModelMapper jsonToModelMapper;
  final ArticleModelToEntityMapper modelToEntityMapper;

  ResponseToEntityGroupMapper({
    required this.jsonToModelMapper,
    required this.modelToEntityMapper,
  });

  List<ArticleEntity> map(List<dynamic> jsonList) {
    return jsonList
        .map((json) => modelToEntityMapper.map(jsonToModelMapper.map(json)))
        .toList();
  }
}
