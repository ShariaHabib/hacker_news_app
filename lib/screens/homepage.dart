import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hacker_news_app/providers/navigation_provider.dart';
import 'package:hacker_news_app/screens/new_stories.dart';
import 'package:hacker_news_app/screens/top_stories.dart';
import 'package:provider/provider.dart';

import '../services/theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> _widgetOptions = <Widget>[
    const NewStories(),
    const TopStories(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/image/logo.svg',
                height: 10,
                width: 10,
              ),
            ),
            automaticallyImplyLeading: false,
            title: const Text('Hacker News'),
            forceMaterialTransparency: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_4),
                onPressed: () {
                  Provider.of<ThemeService>(context, listen: false)
                      .switchTheme();
                },
              )
            ],
          ),
          body: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
            print(navigationProvider.currentIndex);
            return _widgetOptions[navigationProvider.currentIndex];
          }),
          bottomNavigationBar: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.new_releases),
                  label: 'New Stories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up_sharp),
                  label: 'Top Stories',
                ),
              ],
              currentIndex: navigationProvider.currentIndex,
              elevation: 5,
              selectedFontSize: 16,
              onTap: (value) => {
                Provider.of<NavigationProvider>(context, listen: false)
                    .setIndex(value),
              },
            );
          })),
    );
  }
}
