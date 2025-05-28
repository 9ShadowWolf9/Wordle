import 'word.dart';

class WordList {
  static final List<Word> validWords = [
    Word(word: 'APPLE'),
    Word(word: 'BRAIN'),
    Word(word: 'CRANE'),
    Word(word: 'WORDS'),
  ];

  static Word getRandomWord() {
    validWords.shuffle();
    return validWords.first;
  }
}
