import 'package:flutter/material.dart';

//TODO: Create letter tile (default: white bgcolor and grey border)
class LetterTile extends StatelessWidget {
  final String letter;

  const LetterTile({super.key, this.letter = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4), // odstęp między kafelkami
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey,
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


