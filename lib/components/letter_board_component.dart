import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/game_logic.dart';
import 'package:wordle/widgets/letter_tile.dart';

class LetterBoardComponent extends StatelessWidget {
  const LetterBoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

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
                final letter =
                    tileIndex < gameState.guesses[rowIndex].length
                        ? gameState.guesses[rowIndex][tileIndex]
                        : '';
                final status = gameState.tileStatuses[rowIndex][tileIndex];
                return Expanded(
                  child: LetterTile(letter: letter, status: status),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
