import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/common/widgets/common_app_bar.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_case/article_get_uc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/remote/remote_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/home/widgets/body_widget.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    // Retrieve use case from service locator
    final getNewsArticlesUseCase = sl<GetArticleUseCase>();

    return BlocProvider(
      create: (_) =>
          RemoteArticlesCubit(getNewsArticlesUseCase)..fetchArticles(),
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'Daily News',
          showSavedArticlesAction: true,
        ),
        body: buildBody(),
      ),
    );
  }
}
