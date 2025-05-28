import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  final String letter;

  const LetterTile({super.key, this.letter = ""});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary,
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
