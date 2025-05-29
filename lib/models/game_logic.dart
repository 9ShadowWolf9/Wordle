import 'package:flutter/material.dart';
import 'package:wordle/models/word_list.dart';
import 'package:wordle/models/local_dictionary.dart'; // Import your dictionary helper

enum LetterStatus { initial, correct, present, absent }

class GameState extends ChangeNotifier {
  final int maxRows = 6;
  final int wordLength = 5;

  late String targetWord;
  List<String> guesses = List.generate(6, (_) => '');
  List<List<LetterStatus>> tileStatuses = List.generate(
    6,
    (_) => List.filled(5, LetterStatus.initial),
  );
  int currentRow = 0;

  Map<String, LetterStatus> usedKeys = {};

  bool dictionaryLoaded = false;

  GameState() {
    _init();
  }

  Future<void> _init() async {
    await LocalDictionary.loadDictionary();
    dictionaryLoaded = true;
    _generateWord();
    notifyListeners();
  }

  void _generateWord() {
    targetWord = WordList.getRandomWord().word.toUpperCase();
    debugPrint('Target Word: $targetWord');
  }

  void reset() {
    _generateWord();
    guesses = List.generate(maxRows, (_) => '');
    tileStatuses = List.generate(
      maxRows,
      (_) => List.filled(wordLength, LetterStatus.initial),
    );
    usedKeys.clear();
    currentRow = 0;
    notifyListeners();
  }

  void addLetter(String letter) {
    if (guesses[currentRow].length < wordLength) {
      guesses[currentRow] += letter;
      notifyListeners();
    }
  }

  void removeLetter() {
    if (guesses[currentRow].isNotEmpty) {
      guesses[currentRow] = guesses[currentRow].substring(
        0,
        guesses[currentRow].length - 1,
      );
      notifyListeners();
    }
  }

  bool submitWord() {
    if (!dictionaryLoaded) {
      debugPrint('Dictionary not loaded yet.');
      return false;
    }

    if (guesses[currentRow].length != wordLength) return false;

    String guess = guesses[currentRow].toUpperCase();

    if (!LocalDictionary.isValidWord(guess)) {
      debugPrint('Invalid word: $guess');
      return false; // Notify caller the word is invalid
    }

    List<LetterStatus> status = List.filled(wordLength, LetterStatus.absent);
    List<bool> matchedTarget = List.filled(wordLength, false);

    for (int i = 0; i < wordLength; i++) {
      if (guess[i] == targetWord[i]) {
        status[i] = LetterStatus.correct;
        matchedTarget[i] = true;
        usedKeys[guess[i]] = LetterStatus.correct;
      }
    }

    for (int i = 0; i < wordLength; i++) {
      if (status[i] == LetterStatus.correct) continue;
      for (int j = 0; j < wordLength; j++) {
        if (!matchedTarget[j] && guess[i] == targetWord[j]) {
          status[i] = LetterStatus.present;
          matchedTarget[j] = true;

          if (usedKeys[guess[i]] != LetterStatus.correct) {
            usedKeys[guess[i]] = LetterStatus.present;
          }
          break;
        }
      }

      if (status[i] == LetterStatus.absent && !usedKeys.containsKey(guess[i])) {
        usedKeys[guess[i]] = LetterStatus.absent;
      }
    }

    tileStatuses[currentRow] = status;
    currentRow++;
    notifyListeners();
    return true; // Word was valid
  }
}
