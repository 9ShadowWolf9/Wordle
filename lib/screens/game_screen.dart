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
    return Scaffold(backgroundColor: Theme.of(context).colorScheme.surface);
  }
}

//Theme.of(context).colorScheme.surface to sie odwołuje do folderu themes i podajesz który kolor z jasnego/ciemnego ma być
