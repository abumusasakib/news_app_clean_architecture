import 'package:appearance/appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_clean_architecture/config/routes/app_router.dart';
import 'package:news_app_clean_architecture/config/theme/app_themes.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDependencies(); // Initialize the service locator
  await SharedPreferencesManager.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with AppearanceState {
  @override
  Widget build(BuildContext context) {
    return BuildWithAppearance(
        initial: ThemeMode.light,
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            themeMode: Appearance.of(context)?.mode,
            theme: lightTheme,
            darkTheme: darkTheme,
            routerConfig: appRouter,
          );
        });
  }
}
