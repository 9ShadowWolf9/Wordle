import 'package:wordle/widgets/letter_tile.dart';
import 'package:flutter/material.dart';

//TODO: Create 5x6 letter grid using leter tiles
class LetterBoardComponent extends StatelessWidget {
  const LetterBoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // Get max width of screen or limit max width for the board
    final maxBoardWidth = MediaQuery.of(context).size.width * 0.9;
    // Or set fixed max width e.g. 350 for consistency
    final boardWidth = maxBoardWidth > 350 ? 350.0 : maxBoardWidth;

    return Center(
      child: Container(
        width: boardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(6, (rowIndex) {
            return Row(
              children: List.generate(5, (tileIndex) {
                return Expanded(child: LetterTile());
              }),
            );
          }),
        ),
      ),
    );
  }
}
