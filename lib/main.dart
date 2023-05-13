import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticktackworld/customertext.dart';
import 'package:ticktackworld/tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const GameGround(),
    );
  }
}

class GameGround extends StatefulWidget {
  const GameGround({super.key});
  static String currentText = 'O';
  static List<String> analysingList = <String>[
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  static List<String> emojies = [
    '🙂',
    '😐',
    '😥',
    '😴',
    '😎',
    '😕',
    '😜',
    '😁',
    '😯'
  ];
  static String playerOneEmoj = emojies[7];
  static String playerTwoEmoj = emojies[8];
  static String winnerEmoj = emojies[4];
  static String drawEmoj = emojies[1];

  @override
  State<GameGround> createState() => _GameGroundState();
}

class _GameGroundState extends State<GameGround> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int index = Random().nextInt(8);
        int index1 = Random().nextInt(8);

        GameGround.playerOneEmoj = GameGround.emojies[index];
        GameGround.playerTwoEmoj = GameGround.emojies[index1];
        print('tapped');
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            CustomText(text: 'Bosco ${GameGround.playerOneEmoj}'),
            const CustomText(text: 'vs'),
            CustomText(text: 'Justin ${GameGround.playerTwoEmoj}'),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Tile(
                        index: index,
                        winChecker: compare,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void compare() {
    int full = 0;
    for (int i = 0; i < GameGround.analysingList.length; i++) {
      if (GameGround.analysingList[i] == 'X' ||
          GameGround.analysingList[i] == 'O') {
        full++;
      }
    }

    if (full == 9) {
      dialog('Draw!', GameGround.drawEmoj);
      return;
    }
    if (GameGround.analysingList[0] == GameGround.analysingList[1] &&
        GameGround.analysingList[0] == GameGround.analysingList[2]) {
      GameGround.playerOneEmoj = GameGround.winnerEmoj;
      dialog('Bosco Win!', GameGround.winnerEmoj);
    } else if (GameGround.analysingList[0] == GameGround.analysingList[3] &&
        GameGround.analysingList[0] == GameGround.analysingList[6]) {
      GameGround.playerOneEmoj = GameGround.emojies[4];
      dialog('Bosco Win!', GameGround.winnerEmoj);
    } else if (GameGround.analysingList[0] == GameGround.analysingList[4] &&
        GameGround.analysingList[0] == GameGround.analysingList[8]) {
      GameGround.playerTwoEmoj = GameGround.winnerEmoj;
      dialog('Bosco Win!', GameGround.winnerEmoj);
    } else {
      setState(() {
        int index = Random().nextInt(8);
        int index1 = Random().nextInt(8);

        GameGround.playerOneEmoj = GameGround.emojies[index];
        GameGround.playerTwoEmoj = GameGround.emojies[index1];
      });
    }
  }

  dialog(String text, String emoj) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color.fromARGB(200, 53, 49, 49),
              content: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '$text \n $emoj',
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 20, color: Colors.white)]),
                  ),
                ),
              ),
            ));
  }
}
