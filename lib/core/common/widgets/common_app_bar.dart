import 'package:appearance/appearance.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required String title,
  bool showLeading = false,
  bool showSavedArticlesAction = false,
  VoidCallback? onLeadingPressed,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    leading: showLeading
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: onLeadingPressed,
          )
        : null,
    elevation: 2,
    actions: [
      if (showSavedArticlesAction)
        IconButton(
          icon: const Icon(Icons.save_alt, color: Colors.white, size: 30),
          tooltip: 'Saved articles',
          onPressed: () => context.go('/saved-articles'),
        ),
      IconButton(
        icon: Icon(
          Appearance.of(context)?.mode == ThemeMode.light
              ? Icons.dark_mode
              : Icons.light_mode,
          color: Colors.white,
        ),
        tooltip: 'Toggle theme',
        onPressed: () {
          final appearance = Appearance.of(context);
          appearance?.setMode(
            appearance.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    ],
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
  );
}
