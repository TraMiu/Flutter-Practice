import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/words_provider.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vocabulary'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth > 600 ? 48.0 : 16.0;
          final isWideScreen = constraints.maxWidth > 600;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16.0),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Words to Learn',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    
                    // Empty state is static, no need to be in Consumer
                    Expanded(
                      child: _VocabularyListWidget(isWideScreen: isWideScreen),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Extract vocabulary list to its own widget with Consumer
class _VocabularyListWidget extends StatelessWidget {
  final bool isWideScreen;
  
  const _VocabularyListWidget({
    required this.isWideScreen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WordsProvider>(
      builder: (context, wordsProvider, child) {
        final unknownWords = wordsProvider.unknownWords;
        
        if (unknownWords.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.list_alt, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No words added yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Highlight words in the Article tab to add them here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Use grid for wide screens, list for narrow screens
        if (isWideScreen) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: unknownWords.length,
            itemBuilder: (context, index) {
              return _VocabularyCard(word: unknownWords[index]);
            },
          );
        }
        
        return ListView.separated(
          itemCount: unknownWords.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return _VocabularyCard(word: unknownWords[index]);
          },
        );
      },
    );
  }
}

// Extract card to its own widget to optimize rebuilds
class _VocabularyCard extends StatelessWidget {
  final String word;
  
  const _VocabularyCard({
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          word,
          style: TextStyle(fontSize: 18),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            // Access provider only when needed, without rebuilds
            context.read<WordsProvider>().removeWord(word);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Removed "$word" from vocabulary')),
            );
          },
        ),
      ),
    );
  }
}
