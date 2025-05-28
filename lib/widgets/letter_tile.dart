import 'package:flutter/material.dart';

//TODO: Create letter tile (default: white bgcolor and grey border)
class LetterTile extends StatelessWidget {
  final String letter;

  const LetterTile({super.key, this.letter = ""});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // keeps the tile square
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary, // white-ish bg
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
