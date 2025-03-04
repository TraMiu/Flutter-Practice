import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/words_provider.dart';
import 'screens/article_screen.dart';
import 'screens/vocabulary_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WordsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive layout - use side-by-side for wider screens
        final bool isWideScreen = constraints.maxWidth > 600;
        
        if (isWideScreen) {
          // Tablet/desktop layout with side-by-side screens
          return Scaffold(
            appBar: AppBar(
              title: Text('English Learning App'),
            ),
            body: Row(
              children: [
                // Navigation rail for wider screens
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.article),
                      label: Text('Article'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('Vocabulary'),
                    ),
                  ],
                ),
                // Vertical divider between nav rail and content
                VerticalDivider(thickness: 1, width: 1),
                // Main content area - expanded to fill remaining space
                Expanded(
                  child: _currentIndex == 0 ? ArticleScreen() : VocabularyScreen(),
                ),
              ],
            ),
          );
        } else {
          // Mobile layout with bottom navigation
          return Scaffold(
            body: _currentIndex == 0 ? ArticleScreen() : VocabularyScreen(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'Article',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Vocabulary',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
