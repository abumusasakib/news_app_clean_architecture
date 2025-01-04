import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/articles_list.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/empty_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/error_state.dart';

Widget buildStateWidget(
    BuildContext context,
    LocalArticlesState state,
    Function(BuildContext, dynamic) handleDelete,
    Function(BuildContext, dynamic) navigateToDetail,
    String Function(String?) formatDate,
    Animation<Offset> slideAnimation,
  ) {
    if (state is LocalArticlesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is LocalArticlesDone) {
      return state.articles!.isEmpty
          ? buildEmptyState()
          : buildArticlesList(
              context,
              state,
              handleDelete,
              navigateToDetail,
              formatDate,
              slideAnimation,
            );
    }
    return buildErrorState();
  }