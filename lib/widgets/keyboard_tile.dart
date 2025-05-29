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
    ['Ś', 'Ż', 'Ź'],
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
        return const Color(0xFF033774);
      case LetterStatus.present:
        return const Color(0xFFF3C623);
      case LetterStatus.absent:
        return const Color(0xFFD9001A);
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getKeyTextColor(BuildContext context, String key) {
    final gameState = Provider.of<GameState>(context);
    final status = gameState.usedKeys[key];

    if (status == LetterStatus.correct ||
        status == LetterStatus.present ||
        status == LetterStatus.absent) {
      return Colors.white;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 4.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Keyboard rows
        ...keys.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  row.map((key) {
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
                              style: TextStyle(
                                fontSize: 16,
                                color: _getKeyTextColor(context, key),
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

        const SizedBox(height: 8),

        // Bottom row with language switch, ENTER, BACKSPACE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              // Language toggle button
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
                  child: const Icon(
                    Icons.language,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: spacing),

              // ENTER button (flex 2)
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => widget.onKeyPress("ENTER"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "ENTER",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: spacing),

              // BACKSPACE button
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
                  ),
                  child: Icon(Icons.backspace, size: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
