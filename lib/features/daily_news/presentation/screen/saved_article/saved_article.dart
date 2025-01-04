import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_clean_architecture/core/common/widgets/common_app_bar.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/mapper/article_local_to_entity_mapper.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_cubit.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/cubit/article/local/local_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/screen/saved_article/widgets/state_widget.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class SavedArticlesScreen extends HookWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Keeping all hooks at the top level of build
    final scaffoldMessengerKey =
        useMemoized(() => GlobalKey<ScaffoldMessengerState>());
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));

    final slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    // Initialize animation
    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    // Create a hook for the cubit initialization
    final cubit = useMemoized(() => sl<LocalArticleCubit>(), []);

    // Initialize the cubit
    useEffect(() {
      cubit.onGetSavedArticles();
      return null;
    }, [cubit]);

    final handleDelete = useCallback((BuildContext context, dynamic article) {
      final cubit = context.read<LocalArticleCubit>();
      cubit.removeFromState(article);

      // Create a timer to track snackbar duration
      Timer? deletionTimer;
      bool shouldDelete = true;

      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.clearSnackBars();

      // Store the SnackBar closure future
      final snackBarClosed = scaffoldMessenger
          .showSnackBar(
            SnackBar(
              content: Text('${article.title} deleted'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  shouldDelete = false;
                  deletionTimer
                      ?.cancel(); // Cancel the timer if undo is pressed
                  cubit.restoreToState(article);
                },
              ),
            ),
          )
          .closed;

      // Set up the deletion timer
      deletionTimer = Timer(const Duration(seconds: 2), () {
        if (shouldDelete) {
          cubit.onRemoveArticle(article);
        }
      });

      // Handle what happens when snackbar is closed
      snackBarClosed.then((reason) {
        if (reason == SnackBarClosedReason.timeout) {
          // Let the timer handle the deletion
          return;
        } else if (reason == SnackBarClosedReason.dismiss ||
            reason == SnackBarClosedReason.remove ||
            reason == SnackBarClosedReason.hide) {
          deletionTimer?.cancel();
          if (shouldDelete) {
            cubit.onRemoveArticle(article);
          }
        }
      });
    }, []);

    final navigateToDetail =
        useCallback((BuildContext context, dynamic article) {
      final localToEntityMapper = sl<ArticleLocalToEntityMapper>();
      context.push(
        '/article-detail',
        extra: {'article': localToEntityMapper.map(article)},
      );
    }, []);

    final formatDate = useCallback((String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return '';
      try {
        final date = DateTime.parse(dateStr);
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      } catch (e) {
        return dateStr;
      }
    }, []);

    return BlocProvider.value(
      value: cubit, // Using BlocProvider.value instead of creating a new cubit
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            appBar: buildAppBar(
              context: context,
              title: 'Saved Articles',
              showLeading: true,
              onLeadingPressed: () => context.go('/'),
            ),
            body: BlocBuilder<LocalArticleCubit, LocalArticlesState>(
              builder: (context, state) {
                if (state is LocalArticlesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: buildStateWidget(
                    context,
                    state,
                    handleDelete,
                    navigateToDetail,
                    formatDate,
                    slideAnimation,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
