import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/remote/remote_article_cubit.dart';
import 'package:news_app_clean_architecture/core/common/widgets/timeout_image_widget.dart';

Widget buildBody() {
  return BlocBuilder<RemoteArticlesCubit, DataState<List<ArticleEntity>>>(
    builder: (context, state) {
      return state.when(
        initial: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.newspaper, size: 64, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Welcome to the News App',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        success: (articles) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: articles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final article = articles[index];
            if (article.title == '[Removed]') return const SizedBox.shrink();
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => context.push(
                  '/article-detail',
                  extra: {'article': article}, // Pass article data
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: article.urlToImage.isNotEmpty
                          ? TimeoutImageWidget(
                              imageUrl: article.urlToImage,
                              timeout: const Duration(seconds: 5),
                            )
                          : const SizedBox.shrink(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          article.author.isNotEmpty
                              ? Text(article.author,
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : const SizedBox.shrink(),
                          const SizedBox(height: 8),
                          Text(
                              DateFormat('MMM dd, yyyy').format(
                                DateTime.parse(article.publishedAt),
                              ),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        failure: (error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load articles',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Error: ${error.message}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                if (error.response != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${error.response?.statusCode ?? "Unknown"}\n${error.response?.statusMessage ?? "Unknown"}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<RemoteArticlesCubit>().fetchArticles();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
