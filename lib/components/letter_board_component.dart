import 'package:flutter/material.dart';
import 'package:wordle/widgets/letter_tile.dart';

class LetterBoardComponent extends StatelessWidget {
  final List<String> guesses;

  const LetterBoardComponent({super.key, required this.guesses});

  @override
  Widget build(BuildContext context) {
    final maxBoardWidth = MediaQuery.of(context).size.width * 0.9;
    final boardWidth = maxBoardWidth > 350 ? 350.0 : maxBoardWidth;

    return Center(
      child: Container(
        width: boardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(6, (rowIndex) {
            return Row(
              children: List.generate(5, (tileIndex) {
                String letter = '';
                if (tileIndex < guesses[rowIndex].length) {
                  letter = guesses[rowIndex][tileIndex];
                }
                return Expanded(child: LetterTile(letter: letter));
              }),
            );
          }),
        ),
      ),
    );
  }
}
