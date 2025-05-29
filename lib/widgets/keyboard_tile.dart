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
    final screenWidth = MediaQuery.of(context).size.width;
    const horizontalPadding = 16.0;
    const spacing = 4.0;
    final defaultColor = Theme.of(context).colorScheme.primary;

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
              children: row.map((key) {
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
                        style: TextStyle(
                          fontSize: 16,
                          color: _getKeyTextColor(context, key),
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
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => onKeyPress("BACKSPACE"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Icon(
                      Icons.backspace,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
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
