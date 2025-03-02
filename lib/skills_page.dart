import 'package:flutter/material.dart';
import 'todo.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Todo> skills = [
      Todo(
        title: 'Listening',
        exercises: [],
      ),
      Todo(
        title: 'Speaking',
        exercises: [],
      ),
      Todo(
        title: 'Writing',
        exercises: [
          'Reported Speech',
          'Passive Voice',
          'Although/Despite',
          'Because/Because of',
          'Word Form',
        ],
      ),
      Todo(
        title: 'Reading',
        exercises: [],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('English Skills')),
      body: ListView.builder(
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(skills[index].title),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/exercises',
                arguments: skills[index],
              );
            },
          );
        },
      ),
    );
  }
}
