import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticktackworld/main.dart';

class Tile extends StatefulWidget {
  const Tile({
    super.key,
    required this.index,
    required this.winChecker,
  });
  final int index;
  final Function winChecker;
  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  String symbol = '';

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          if (symbol == '') {
            symbol = GameGround.currentText;
            if (GameGround.currentText != 'X') {
              GameGround.currentText = 'X';
            } else {
              GameGround.currentText = 'O';
            }
            GameGround.analysingList[widget.index] = symbol;
          }
        });
        widget.winChecker();
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            color: Colors.transparent),
        child: Center(
          child: Text(
            symbol,
            style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 20, color: Colors.white)]),
          ),
        ),
      ),
    );
  }
}
