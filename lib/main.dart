import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'English Exercise',
      home: ExerciseScreen(),
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final _controller = TextEditingController();
  Color _backgroundColor = Colors.white;

  void _checkAnswer() {
    setState(() {
      if (_controller.text.trim().toLowerCase() == 'has been studying' ||
          _controller.text.trim().toLowerCase() == 'has studied') {
        _backgroundColor = Colors.green;
      } else {
        _backgroundColor = Colors.red;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('English Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('He ', style: TextStyle(fontSize: 20)),
                Expanded(
                  child: Container(
                    color: _backgroundColor,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '',
                      ),
                    ),
                  ),
                ),
                const Text(' for 10 years (study)', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Check Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
