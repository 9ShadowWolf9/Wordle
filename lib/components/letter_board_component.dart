import 'package:wordle/widgets/letter_tile.dart';
import 'package:flutter/material.dart';

//TODO: Create 5x6 letter grid using leter tiles
class LetterBoardComponent extends StatelessWidget {
  const LetterBoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
              LetterTile(),
            ],
          ),
        ],
      ),
    );
  }
}
