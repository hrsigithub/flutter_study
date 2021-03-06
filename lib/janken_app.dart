// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';

enum JankenType { GUU, CYOKI, PAA }
enum JankenResult { WIN, LOSE, DRAW }

class JankenApp extends StatelessWidget {
  const JankenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  JankenType myHand = JankenType.GUU;
  JankenType computerHand = JankenType.GUU;
  JankenResult result = JankenResult.DRAW;

  String _cvHand(JankenType type) {
    switch (type) {
      case JankenType.GUU:
        return "✊";
      case JankenType.CYOKI:
        return "✌";
      case JankenType.PAA:
        return "✋";
      default:
        return "✊";
    }
  }

  String _cvResult(JankenResult type) {
    switch (type) {
      case JankenResult.WIN:
        return "おめーの勝ち！";
      case JankenResult.LOSE:
        return "まけだがや。がはは";
      case JankenResult.DRAW:
        return "なぬー！";
      default:
        return "なぬー！";
    }
  }

    JankenType randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return JankenType.GUU;
      case 1:
        return JankenType.CYOKI;
      case 2:
        return JankenType.PAA;
      default:
        return JankenType.GUU;
    }
  }

    void selectHand(JankenType type) {
    myHand = type;
    generateComputerHand();
    judge();
    setState(() {});
  }

  void generateComputerHand() {
    computerHand = randomNumberToHand(Random().nextInt(3));
  }

  void judge() {
    if (myHand == computerHand) {
      result = JankenResult.DRAW;
    
    } else if ((myHand == JankenType.GUU &&
            computerHand == JankenType.CYOKI) ||
        (myHand == JankenType.CYOKI &&
            computerHand == JankenType.PAA) ||
        (myHand == JankenType.PAA &&
            computerHand == JankenType.GUU)) {
      result = JankenResult.WIN;
    } else {
      result = JankenResult.LOSE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('じゃんけん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_cvResult(result), style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 64),
            Text(_cvHand(computerHand), style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 64),
            Text(_cvHand(myHand), style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand(JankenType.GUU);
                  },
                  child: Text(_cvHand(JankenType.GUU)),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand(JankenType.CYOKI);
                  },
                  child: Text(_cvHand(JankenType.CYOKI)),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand(JankenType.PAA);
                  },
                  child: Text(_cvHand(JankenType.PAA)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





