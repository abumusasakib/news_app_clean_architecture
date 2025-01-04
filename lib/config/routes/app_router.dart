import 'package:go_router/go_router.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/article_detail/article_detail.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/home/daily_news.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/saved_article.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DailyNews(),
    ),
    GoRoute(
      path: '/saved-articles',
      builder: (context, state) => const SavedArticlesScreen(),
    ),
    GoRoute(
      path: '/article-detail',
      builder: (context, state) {
        final article = state.extra as Map<String, dynamic>;
        return ArticleDetailScreen(
          article: article['article'],
        );
      },
    ),
  ],
);
