import 'package:flutter/material.dart';

class WordsProvider extends ChangeNotifier {
  // Unknown words data
  final List<String> _unknownWords = [];
  
  // Article content
  final String _articleContent = 
      'Flutter is Google\'s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. '
      'Learning a new language can be challenging, but with regular practice and exposure to authentic content, you can improve your skills quickly. '
      'Reading articles in your target language is one of the most effective ways to expand your vocabulary and understand how words are used in context.';

  // Getters
  List<String> get unknownWords => _unknownWords;
  String get articleContent => _articleContent;

  // Methods
  void addWord(String word) {
    if (!_unknownWords.contains(word) && word.isNotEmpty) {
      _unknownWords.add(word);
      notifyListeners();
    }
  }

  void removeWord(String word) {
    if (_unknownWords.contains(word)) {
      _unknownWords.remove(word);
      notifyListeners();
    }
  }
}
