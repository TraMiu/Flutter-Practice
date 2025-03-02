import 'package:flutter/material.dart';
import 'todo.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context)!.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(title: Text('${todo.title} Exercises')),
      body: ListView.builder(
        itemCount: todo.exercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todo.exercises[index]),
            enabled: todo.title == 'Writing',
          );
        },
      ),
    );
  }
}
