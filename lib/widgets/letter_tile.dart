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
        return Colors.green;
      case LetterStatus.present:
        return Colors.orange;
      case LetterStatus.absent:
        return Colors.grey;
      case LetterStatus.initial:
      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
