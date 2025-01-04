import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/datasource/local/DAO/article_dao.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/database/article_local_entity.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleLocalEntity, ArticleLocalSourceEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDAO;
}
