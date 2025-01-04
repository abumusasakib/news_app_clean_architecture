part of 'article_detail_cubit.dart';

class ArticleDetailState {
  final bool isArticleSaved;
  final bool isCheckingSaveStatus;

  const ArticleDetailState({
    required this.isArticleSaved,
    required this.isCheckingSaveStatus,
  });

  factory ArticleDetailState.initial() {
    return const ArticleDetailState(
      isArticleSaved: false,
      isCheckingSaveStatus: true,
    );
  }

  ArticleDetailState copyWith({
    bool? isArticleSaved,
    bool? isCheckingSaveStatus,
  }) {
    return ArticleDetailState(
      isArticleSaved: isArticleSaved ?? this.isArticleSaved,
      isCheckingSaveStatus: isCheckingSaveStatus ?? this.isCheckingSaveStatus,
    );
  }
}
