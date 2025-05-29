import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/game_logic.dart';

class OnScreenKeyboard extends StatefulWidget {
  final Function(String) onKeyPress;
  final bool gameOver;

  OnScreenKeyboard({
    super.key,
    required this.onKeyPress,
    required this.gameOver,
  });

  @override
  State<OnScreenKeyboard> createState() => _OnScreenKeyboardState();
}

class _OnScreenKeyboardState extends State<OnScreenKeyboard> {
  bool isPolish = false;

  List<List<String>> get keys => isPolish ? polishKeys : englishKeys;

  final List<List<String>> polishKeys = [
    ['Q', 'W', 'Ę', 'R', 'T', 'Y', 'U', 'I', 'Ó', 'P'],
    ['Ą', 'Ś', 'D', 'F', 'G', 'H', 'J', 'K', 'Ł'],
    ['Ż', 'Ź', 'Ć', 'V', 'B', 'Ń', 'M'],
  ];

  final List<List<String>> englishKeys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];
  bool _isPolishOnlyLetter(String key) {
    const polishOnlyLetters = {'Ę', 'Ó', 'Ą', 'Ś', 'Ł', 'Ż', 'Ź', 'Ć', 'Ń'};
    return polishOnlyLetters.contains(key);
  }

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
                            onPressed: () {
                              widget.onKeyPress(key);
                              if (isPolish && _isPolishOnlyLetter(key)) {
                                setState(() {
                                  isPolish = false;
                                });
                              }
                            },

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

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => setState(() => isPolish = !isPolish),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(
                    Icons.language,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: spacing),

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

              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => widget.onKeyPress("BACKSPACE"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(
                    Icons.backspace,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
