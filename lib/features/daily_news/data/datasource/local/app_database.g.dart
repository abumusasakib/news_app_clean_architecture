// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao? _articleDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `articles` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sourceId` TEXT NOT NULL, `sourceName` TEXT NOT NULL, `author` TEXT, `title` TEXT NOT NULL, `description` TEXT, `url` TEXT NOT NULL, `urlToImage` TEXT, `publishedAt` TEXT NOT NULL, `content` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `article_sources` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDAO {
    return _articleDAOInstance ??= _$ArticleDao(database, changeListener);
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _articleLocalEntityInsertionAdapter = InsertionAdapter(
            database,
            'articles',
            (ArticleLocalEntity item) => <String, Object?>{
                  'id': item.id,
                  'sourceId': item.sourceId,
                  'sourceName': item.sourceName,
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                }),
        _articleLocalEntityDeletionAdapter = DeletionAdapter(
            database,
            'articles',
            ['id'],
            (ArticleLocalEntity item) => <String, Object?>{
                  'id': item.id,
                  'sourceId': item.sourceId,
                  'sourceName': item.sourceName,
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleLocalEntity>
      _articleLocalEntityInsertionAdapter;

  final DeletionAdapter<ArticleLocalEntity> _articleLocalEntityDeletionAdapter;

  @override
  Future<List<ArticleLocalEntity>> getArticles() async {
    return _queryAdapter.queryList('SELECT * FROM articles',
        mapper: (Map<String, Object?> row) => ArticleLocalEntity(
            id: row['id'] as int?,
            sourceId: row['sourceId'] as String,
            sourceName: row['sourceName'] as String,
            author: row['author'] as String?,
            title: row['title'] as String,
            description: row['description'] as String?,
            url: row['url'] as String,
            urlToImage: row['urlToImage'] as String?,
            publishedAt: row['publishedAt'] as String,
            content: row['content'] as String?));
  }

  @override
  Future<void> deleteArticleById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM articles WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllArticles() async {
    await _queryAdapter.queryNoReturn('DELETE FROM articles');
  }

  @override
  Future<void> insertArticle(ArticleLocalEntity article) async {
    await _articleLocalEntityInsertionAdapter.insert(
        article, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertArticles(List<ArticleLocalEntity> articles) async {
    await _articleLocalEntityInsertionAdapter.insertList(
        articles, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteArticle(ArticleLocalEntity article) async {
    await _articleLocalEntityDeletionAdapter.delete(article);
  }
}
