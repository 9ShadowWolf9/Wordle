import 'package:flutter/material.dart';
import 'package:wordle/models/game_logic.dart';
import 'package:wordle/widgets/letter_tile.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zasady Gry'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'JAK GRAĆ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Odgadnij WORDLE w 6 próbach.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Każda próba musi być poprawnym pięcioliterowym słowem. Naciśnij Enter, aby zatwierdzić.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Po każdej próbie kolor pól zmieni się, pokazując, jak blisko jesteś odgadnięcia słowa.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Przykłady:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _exampleRow(
              context,
              'WEARY',
              0,
              LetterStatus.correct,
              'Litera W jest w słowie i na właściwym miejscu.',
            ),
            const SizedBox(height: 12),
            _exampleRow(
              context,
              'PILLS',
              1,
              LetterStatus.present,
              'Litera I jest w słowie, ale na niewłaściwym miejscu.',
            ),
            const SizedBox(height: 12),
            _exampleRow(
              context,
              'VAGUE',
              3,
              LetterStatus.absent,
              'Litera U nie występuje w słowie.',
            ),
          ],
        ),
      ),
    );
  }

  static Widget _exampleRow(
    BuildContext context,
    String word,
    int highlightIndex,
    LetterStatus status,
    String explanation,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(word.length, (index) {
            return Expanded(
              child: LetterTile(
                letter: word[index],
                status: index == highlightIndex ? status : LetterStatus.initial,
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(explanation),
      ],
    );
  }
}
