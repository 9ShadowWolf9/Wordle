import 'package:wordle/widgets/letter_tile.dart';
import 'package:flutter/material.dart';

class LetterBoardComponent extends StatelessWidget {
  const LetterBoardComponent({super.key});

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
                return Expanded(child: LetterTile());
              }),
            );
          }),
        ),
      ),
    );
  }
}
