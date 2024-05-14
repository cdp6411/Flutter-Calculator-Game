import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameState extends ChangeNotifier {
  int totalSeconds = 5;
  int points = 0;
  int lives = 3;
  String operation = '+';
  int num1 = 0;
  int num2 = 0;
  int answer = 0;
  String currentAnswer = '';
  Timer? timer;
  int seconds = 0;
  bool isGameOver = false;
  double _containerHeight = 0.0;
  double get containerHeight => _containerHeight;

  GameState() {
    generateOperation();
  }

  void generateOperation() {
    num1 = _generateNumber();
    num2 = _generateNumber();
    operation = _generateOperation();
    if (operation == '+') {
      answer = num1 + num2;
    } else {
      answer = num1 * num2;
    }
    notifyListeners();
  }

  int _generateNumber() {
    return 1 + Random().nextInt(9);
  }

  String _generateOperation() {
    return (DateTime.now().millisecond % 2 == 0) ? '+' : '*';
  }

  void appendToAnswer(String value) {
    currentAnswer += value;
    notifyListeners();
  }

  void clearAnswer() {
    currentAnswer = '';
    notifyListeners();
  }

  void submitAnswer(BuildContext context) {
    int userAnswer = int.tryParse(currentAnswer) ?? 0;
    if (userAnswer == answer) {
      points += 10;
    } else {
      lives--;
      notifyListeners();
    }
    timer?.cancel();
    seconds = 0;
    _containerHeight = seconds / totalSeconds;
    if (lives <= 0 && !isGameOver) {
      showGameOverDialog(context);
      isGameOver = true;
      return;
    }
    if (!isGameOver) {
      generateOperation();
      clearAnswer();
      startTimer(context);
      notifyListeners();
    }
  }

  void startTimer(BuildContext context) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds++;
      _containerHeight = seconds / totalSeconds;
      if (seconds >= totalSeconds) {
        timer.cancel();
        seconds = 0;
        lives--;
        notifyListeners();
        if (lives <= 0 && !isGameOver) {
          showGameOverDialog(context);
          isGameOver = true;
          return;
        }
        if (!isGameOver) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            generateOperation();
          });
          startTimer(context);
        }
      }
      notifyListeners();
    });
  }

  void showGameOverDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Points: $points'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame(context);
              },
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
      context: context,
    );
  }

  void resetGame(BuildContext context) {
    points = 0;
    lives = 3;
    isGameOver = false;
    seconds = 0;
    _containerHeight = 0.0;
    currentAnswer = '';
    generateOperation();
    startTimer(context);
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
