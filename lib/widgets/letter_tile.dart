import 'package:flutter/material.dart';
import 'package:wordle/models/game_logic.dart';

class LetterTile extends StatelessWidget {
  final String letter;
  final LetterStatus status;

  const LetterTile({
    super.key,
    this.letter = "",
    this.status = LetterStatus.initial,
  });

  Color _getBackgroundColor(BuildContext context) {
    switch (status) {
      case LetterStatus.correct:
        return const Color(0xFF033774);
      case LetterStatus.present:
        return const Color(0xFFF3C623);
      case LetterStatus.absent:
        return const Color(0xFFD9001A);
      case LetterStatus.initial:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (status == LetterStatus.correct ||
        status == LetterStatus.present ||
        status == LetterStatus.absent) {
      return Colors.white;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getBorderColor(BuildContext context) {
    if (status == LetterStatus.initial) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return _getBackgroundColor(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor(context);
    final borderColor = _getBorderColor(context);

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _getTextColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
