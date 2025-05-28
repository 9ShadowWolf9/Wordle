import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/letter_board_component.dart';
import 'package:wordle/models/game_logic.dart';
import 'package:wordle/widgets/keyboard_tile.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);

    void handleKeyPress(String key) {
      if (key == 'ENTER') {
        gameState.submitWord();
      } else if (key == 'BACKSPACE') {
        gameState.removeLetter();
      } else if (RegExp(r'^[A-Z]$').hasMatch(key)) {
        gameState.addLetter(key);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const LetterBoardComponent(),
            OnScreenKeyboard(onKeyPress: handleKeyPress),
          ],
        ),
      ),
    );
  }
}
