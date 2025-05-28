import 'package:flutter/material.dart';
import 'package:wordle/components/letter_board_component.dart';
import 'package:wordle/widgets/keyboard_tile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int maxWordLength = 5;
  final int maxRows = 6;

  List<String> guesses = List.generate(6, (_) => '');
  int currentRow = 0;

  void _handleKeyPress(String key) {
    setState(() {
      if (key == 'ENTER') {
        if (guesses[currentRow].length == maxWordLength) {
          print('Entered word: ${guesses[currentRow]}');
          // TODO: Word validation logic here
          if (currentRow < maxRows - 1) {
            currentRow++;
          }
        }
      } else if (key == 'BACKSPACE' || key == '←') {
        if (guesses[currentRow].isNotEmpty) {
          guesses[currentRow] = guesses[currentRow].substring(
            0,
            guesses[currentRow].length - 1,
          );
        }
      } else if (guesses[currentRow].length < maxWordLength &&
          RegExp(r'^[A-Z]$').hasMatch(key)) {
        guesses[currentRow] += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LetterBoardComponent(guesses: guesses),
            OnScreenKeyboard(onKeyPress: _handleKeyPress),
          ],
        ),
      ),
    );
  }
}
