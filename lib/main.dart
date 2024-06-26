import 'package:flutter/material.dart';
import 'package:hacker_news_app/providers/comments_provider.dart';
import 'package:hacker_news_app/providers/new_story_provider.dart';
import 'package:hacker_news_app/screens/splash_screen.dart';
import 'package:hacker_news_app/services/theme.dart';
import 'package:provider/provider.dart';

import 'providers/navigation_provider.dart';
import 'providers/top_story_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => TopStoryProvider()),
        ChangeNotifierProvider(create: (_) => CommentsProvider()),
        ChangeNotifierProvider(create: (_) => NewStoryProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeService.theme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
