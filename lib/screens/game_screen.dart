import 'package:flutter/material.dart';
import 'package:wordle/widgets/keyboard_tile.dart'; // Custom keyboard widget

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String currentInput = '';
  final int maxWordLength = 5;

  void _handleKeyPress(String key) {
    setState(() {
      if (key == 'ENTER') {
        if (currentInput.length == maxWordLength) {
          print('Entered word: $currentInput');
          // TODO: Handle word validation and game logic here
          currentInput = '';
        }
      } else if (key == 'BACKSPACE' || key == '←') {
        if (currentInput.isNotEmpty) {
          currentInput = currentInput.substring(0, currentInput.length - 1);
        }
      } else if (currentInput.length < maxWordLength) {
        currentInput += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                currentInput,
                style: const TextStyle(fontSize: 28, letterSpacing: 8),
              ),
            ),
            const Spacer(),
            OnScreenKeyboard(onKeyPress: _handleKeyPress),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}