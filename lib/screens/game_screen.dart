import 'package:flutter/material.dart';
import 'package:wordle/widgets/letter_tile.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Row(children: [LetterTile(), LetterTile()]));
  }
}
