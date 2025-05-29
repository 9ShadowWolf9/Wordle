import 'package:flutter/services.dart' show rootBundle;

class LocalDictionary {
  static final Set<String> _words = {};

  static Future<void> loadDictionary() async {
    final dictionaryString = await rootBundle.loadString(
      'assets/dictionary.txt',
    );
    final lines = dictionaryString.split('\n');
    _words.clear();
    for (var line in lines) {
      String word = line.trim().toUpperCase();
      if (word.isNotEmpty) {
        _words.add(word);
      }
    }
    print('Loaded ${_words.length} words from dictionary');
  }

  static bool isValidWord(String word) {
    return _words.contains(word.toUpperCase());
  }
}
