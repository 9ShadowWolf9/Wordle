import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/letter_board_component.dart';
import 'package:wordle/models/game_logic.dart';
import 'package:wordle/widgets/keyboard_tile.dart';
import 'package:another_flushbar/flushbar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _showInvalidWordNotification(BuildContext context) {
    Flushbar(
      message: 'Podane słowo nie istnieje',
      title: "Błąd",
      duration: const Duration(milliseconds: 900),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.redAccent,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);

    void handleKeyPress(String key) {
      if (key == 'ENTER') {
        final isValid = gameState.submitWord();

        if (!isValid) {
          _showInvalidWordNotification(context);
        }
      } else if (key == 'BACKSPACE') {
        gameState.removeLetter();
      } else {
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
