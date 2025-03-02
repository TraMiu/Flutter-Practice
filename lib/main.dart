import 'package:flutter/material.dart';
import 'skills_page.dart';
import 'exercises_page.dart';
import 'todo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Skills',
      initialRoute: '/',
      routes: {
        '/': (context) => const SkillsPage(),
        '/exercises': (context) => const ExercisesPage(),
      },
    );
  }
}
