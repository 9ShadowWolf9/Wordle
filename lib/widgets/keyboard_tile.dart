import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/game_logic.dart';

class OnScreenKeyboard extends StatefulWidget {
  final Function(String) onKeyPress;

  OnScreenKeyboard({super.key, required this.onKeyPress});

  @override
  State<OnScreenKeyboard> createState() => _OnScreenKeyboardState();
}

class _OnScreenKeyboardState extends State<OnScreenKeyboard> {
  bool isPolish = true;

  List<List<String>> get keys => isPolish ? polishKeys : englishKeys;

  final List<List<String>> polishKeys = [
    ['Ą', 'Ć', 'Ę'],
    ['Ł', 'Ń', 'Ó'],
    ['Ś' ,'Ż', 'Ź'],
  ];

  final List<List<String>> englishKeys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  Color _getKeyColor(BuildContext context, String key) {
    final gameState = Provider.of<GameState>(context);
    final status = gameState.usedKeys[key];

    switch (status) {
      case LetterStatus.correct:
        return Colors.green;
      case LetterStatus.present:
        return Colors.orange;
      case LetterStatus.absent:
        return Colors.grey;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 4.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔤 Klawiatura literowa
        ...keys.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((key) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: key != row.last ? spacing : 0,
                    ),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => widget.onKeyPress(key),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getKeyColor(context, key),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),

        const SizedBox(height: 4),

        // 🔘 ENTER, BACKSPACE i język
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              // 🌐 Przycisk zmiany języka
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => setState(() => isPolish = !isPolish),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.language, size: 20, color: Colors.black),
                ),
              ),
              const SizedBox(width: spacing),

              // ENTER
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => widget.onKeyPress("ENTER"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "ENTER",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: spacing),

              // BACKSPACE
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => widget.onKeyPress("BACKSPACE"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                  ),
                  child: const Icon(Icons.backspace, size: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}