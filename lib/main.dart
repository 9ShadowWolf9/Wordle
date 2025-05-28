import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

//TODO: choose color palette
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Wordle"), centerTitle: true),
        body: GameScreen(),
      ),
    ),
  );
}
