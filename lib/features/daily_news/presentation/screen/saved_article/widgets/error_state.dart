import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_cubit.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

Widget buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => sl<LocalArticleCubit>().onGetSavedArticles(),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }