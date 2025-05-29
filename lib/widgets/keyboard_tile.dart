import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/game_logic.dart';

class OnScreenKeyboard extends StatelessWidget {
  final Function(String) onKeyPress;

  OnScreenKeyboard({super.key, required this.onKeyPress});

  final List<List<String>> keys = [
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
    final screenWidth = MediaQuery.of(context).size.width;
    const horizontalPadding = 16.0;
    const spacing = 4.0;
    final defaultColor = Colors.grey.shade400;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...keys.map((row) {
          final totalSpacing = spacing * (row.length - 1);
          final buttonWidth =
              (screenWidth - horizontalPadding * 2 - totalSpacing) / row.length;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  row.map((key) {
                    return Container(
                      margin: EdgeInsets.only(
                        right: key != row.last ? spacing : 0,
                      ),
                      child: SizedBox(
                        width: buttonWidth,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => onKeyPress(key),
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
                    );
                  }).toList(),
            ),
          );
        }).toList(),

        const SizedBox(height: 4),

        // ENTER + BACKSPACE row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => onKeyPress("ENTER"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: defaultColor,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => onKeyPress("BACKSPACE"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Icon(
                      Icons.backspace,
                      size: 20,
                      color: Colors.black,
                    ),
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
