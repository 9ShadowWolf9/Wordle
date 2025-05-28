import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnScreenKeyboard extends StatelessWidget {
  final Function(String) onKeyPress;

  OnScreenKeyboard({required this.onKeyPress});

  final List<List<String>> keys = [
    ['Q','W','E','R','T','Y','U','I','O','P'],
    ['A','S','D','F','G','H','J','K','L'],
    ['Z','X','C','V','B','N','M'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...keys.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2), // tighter spacing
                child: ElevatedButton(
                  onPressed: () => onKeyPress(key),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    minimumSize: const Size(36, 48), // normal size
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(key, style: const TextStyle(fontSize: 16, color: Colors.black)),
                ),
              );
            }).toList(),
          );
        }).toList(),
        const SizedBox(height: 4), // minimal spacing between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: ElevatedButton(
                onPressed: () => onKeyPress("ENTER"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  minimumSize: const Size(70, 48),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text("ENTER", style: TextStyle(fontSize: 14, color: Colors.black)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: ElevatedButton(
                onPressed: () => onKeyPress("BACKSPACE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  minimumSize: const Size(48, 48),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Icon(Icons.backspace, size: 20, color: Colors.black,),
              ),
            ),
          ],
        ),
      ],
    );
  }
}