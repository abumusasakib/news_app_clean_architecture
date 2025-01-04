import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/confirm_delete.dart';

Widget buildArticleItem(
    BuildContext context,
    dynamic article,
    Function(BuildContext, dynamic) handleDelete,
    Function(BuildContext, dynamic) navigateToDetail,
    String Function(String?) formatDate,
  ) {
    return Dismissible(
      key: ValueKey(article.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => handleDelete(context, article),
      confirmDismiss: (direction) => confirmDelete(context),
      background: Container(
        color: Colors.red[400],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            article.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                article.author ?? "Unknown Author",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
              if (article.publishedAt != null) ...[
                const SizedBox(height: 4),
                Text(
                  formatDate(article.publishedAt),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          onTap: () => navigateToDetail(context, article),
        ),
      ),
    );
  }