import 'package:flutter/material.dart';

//TODO: Create letter tile (default: white bgcolor and grey border)
class LetterTile extends StatelessWidget {
  const LetterTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      height: 80,
      width: 65,
      child: Center(
        child: Text("A", style: TextStyle(color: Colors.white, fontSize: 35)),
      ),
    );
  }
}
