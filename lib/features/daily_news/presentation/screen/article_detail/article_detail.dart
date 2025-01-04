import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entity/article_entity.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/mapper/article_entity_to_local_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_saved_articles_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article_detail/article_detail_cubit.dart';
import 'package:news_app_clean_architecture/core/common/widgets/timeout_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:news_app_clean_architecture/injection_container.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_save_uc.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleDetailCubit(
        getSavedArticlesUseCase: sl<GetSavedArticlesUseCase>(),
        saveArticleUseCase: sl<SaveArticleUseCase>(),
        entityToLocalMapper: sl<ArticleEntityToLocalMapper>(),
      )..checkIfArticleIsSaved(article.url),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            _buildArticleContent(context),
          ],
        ),
        floatingActionButton: _buildSaveButton(context),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: article.url,
          child: _buildArticleImage(),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      actions: [
        if (Uri.tryParse(article.url) != null) ...[
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share(
                'Check out this article: ${article.title}\n${article.url}',
                subject: article.title,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser, color: Colors.white),
            onPressed: () async {
              await launchUrl(
                Uri.parse(article.url),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ],
    );
  }

  SliverToBoxAdapter _buildArticleContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        transform: Matrix4.translationValues(0, -20, 0),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 20),
            if (article.author.isNotEmpty) ...[
              Text(
                'By ${article.author}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 10),
            ],
            ...[
              Text(
                'Published on ${DateFormat('MMM dd, yyyy • hh:mm a').format(
                  DateTime.parse(article.publishedAt),
                )}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 20),
            ],
            if (article.description.isNotEmpty) ...[
              Text(
                article.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
            ],
            if (article.content.isNotEmpty) ...[
              Text(
                article.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
            const SizedBox(height: 32),
            if (Uri.tryParse(article.url) != null)
              ElevatedButton.icon(
                onPressed: () async {
                  await launchUrl(
                    Uri.parse(article.url),
                    mode: LaunchMode.externalApplication,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.article_outlined),
                label: const Text(
                  'Read Full Article',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
      builder: (context, state) {
        if (state.isCheckingSaveStatus) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton(
          onPressed: state.isArticleSaved
              ? null
              : () {
                  context.read<ArticleDetailCubit>().saveArticle(article);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Article saved successfully!')),
                  );
                },
          backgroundColor: state.isArticleSaved
              ? Theme.of(context).disabledColor
              : Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: Icon(
            state.isArticleSaved ? Icons.bookmark_added : Icons.bookmark_add,
            color: state.isArticleSaved
                ? Colors.grey[400]
                : Theme.of(context).floatingActionButtonTheme.foregroundColor,
          ),
        );
      },
    );
  }

  Widget _buildArticleImage() {
    if (article.urlToImage.isEmpty) {
      return const SizedBox.shrink();
    }

    return TimeoutImageWidget(
      imageUrl: article.urlToImage,
      timeout: const Duration(seconds: 5),
    );
  }
}
