import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/article_item.dart';

Widget buildArticlesList(
    BuildContext context,
    LocalArticlesDone state,
    Function(BuildContext, dynamic) handleDelete,
    Function(BuildContext, dynamic) navigateToDetail,
    String Function(String?) formatDate,
    Animation<Offset> slideAnimation,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.articles!.length,
      itemBuilder: (context, index) {
        final article = state.articles![index];
        return SlideTransition(
          position: slideAnimation,
          child: buildArticleItem(
            context,
            article,
            handleDelete,
            navigateToDetail,
            formatDate,
          ),
        );
      },
    );
  }