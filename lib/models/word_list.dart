import 'word.dart';

class WordList {
  static final List<Word> validWords = [
    Word(word: 'RYNEK'),
    Word(word: 'KASKA'),
    Word(word: 'AKCJA'),
    Word(word: 'FIRMA'),
    Word(word: 'CENNY'),
    Word(word: 'ZYSKI'),
    Word(word: 'KOSZT'),
    Word(word: 'DŁUGI'),
    Word(word: 'BRAKI'),
    Word(word: 'TANIO'),
    Word(word: 'LOBBY'),
    Word(word: 'RABAT'),
    Word(word: 'LOKAT'),
    Word(word: 'TOWAR'),
    Word(word: 'PŁACA'),
    Word(word: 'RENTA'),
    Word(word: 'LIMIT'),
    Word(word: 'MARŻA'),
    Word(word: 'NORMA'),
    Word(word: 'BONUS'),
    Word(word: 'ETATY'),
    Word(word: 'GRATY'),
    Word(word: 'OBIEG'),
    Word(word: 'KWOTA'),
    Word(word: 'SALDO'),
    Word(word: 'STAWY'),
    Word(word: 'PŁACE'),
    Word(word: 'STOPY'),
    Word(word: 'ZAPAS'),
    Word(word: 'FUZJA'),
    Word(word: 'ORLEN'),
    Word(word: 'APPLE'),
    Word(word: 'GROSZ'),
    Word(word: 'SKALA'),
    Word(word: 'PLANY'),
  ];
  static Word getRandomWord() {
    validWords.shuffle();
    return validWords.first;
  }
}
