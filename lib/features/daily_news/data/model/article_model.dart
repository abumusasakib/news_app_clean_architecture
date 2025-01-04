import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required ArticleSourceModel source,
    String? author,
    required String title,
    String? description,
    required String url,
    String? urlToImage,
    required String publishedAt,
    String? content,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@freezed
class ArticleSourceModel with _$ArticleSourceModel {
  const factory ArticleSourceModel({
    String? id,
    required String name,
  }) = _ArticleSourceModel;

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceModelFromJson(json);
}