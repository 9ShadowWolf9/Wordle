import 'package:flutter/material.dart';
import 'package:wordle/widgets/letter_tile.dart';
import 'package:wordle/components/letter_board_component.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: LetterBoardComponent(),
          ),
          Expanded(
            child: Container(child: Text('Klawaitura'), color: Colors.red),
          ),
        ],
      ),
    );
  }
}

//Theme.of(context).colorScheme.surface to sie odwołuje do folderu themes i podajesz który kolor z jasnego/ciemnego ma być
