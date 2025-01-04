import 'package:floor/floor.dart';

@Entity(tableName: 'articles')
class ArticleLocalEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id; // Primary key for the Floor table
  final String sourceId;
  final String sourceName;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  ArticleLocalEntity({
    this.id,
    required this.sourceId,
    required this.sourceName,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });
}

@Entity(tableName: 'article_sources')
class ArticleLocalSourceEntity {
  @PrimaryKey()
  final String id;
  final String name;

  ArticleLocalSourceEntity({
    required this.id,
    required this.name,
  });
}
