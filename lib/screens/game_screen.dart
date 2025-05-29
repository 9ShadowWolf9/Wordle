import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/letter_board_component.dart';
import 'package:wordle/models/game_logic.dart';
import 'package:wordle/widgets/keyboard_tile.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _showLoseDialog(BuildContext context, GameState gameState) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "😢 Przegrałeś!",
      desc: "Prawidłowe słowo to: ${gameState.targetWord}",
      buttons: [
        DialogButton(
          child: const Text(
            "Spróbuj ponownie",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            gameState.reset();
            Navigator.pop(context);
          },
          color: Colors.redAccent,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  void _showWinDialog(BuildContext context, GameState gameState) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "🎉 Wygrałeś!",
      desc: "Udało Ci się odgadnąć słowo!",
      buttons: [
        DialogButton(
          child: const Text(
            "Zagraj ponownie",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            gameState.reset();
            Navigator.pop(context);
          },
          color: Colors.green,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);

    void handleKeyPress(String key) {
      final gameState = Provider.of<GameState>(context, listen: false);

      if (gameState.gameOver) {
        debugPrint("Gra zakończona. Zresetuj, aby kontynuować.");
        return;
      }

      if (key == 'ENTER') {
        gameState.submitWord();
      } else if (key == 'BACKSPACE') {
        gameState.removeLetter();
      } else {
        gameState.addLetter(key);
      }
    }

    return Consumer<GameState>(
      builder: (context, gameState, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (gameState.gameWon) {
            _showWinDialog(context, gameState);
          } else if (gameState.gameLost) {
            _showLoseDialog(context, gameState);
          }
        });

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const LetterBoardComponent(),
                Consumer<GameState>(
                  builder: (context, gameState, _) {
                    return OnScreenKeyboard(
                      onKeyPress: handleKeyPress,
                      gameOver: gameState.gameOver,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
