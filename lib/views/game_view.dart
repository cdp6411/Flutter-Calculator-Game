import 'package:dot3_demo/constant/app_colors.dart';
import 'package:dot3_demo/provider/game_provider.dart';
import 'package:dot3_demo/widgets/dialpad_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GameState>().startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  color: AppColors.iconColor,
                  height: gameState.containerHeight *
                      MediaQuery.of(context).size.height *
                      0.561,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Selector<GameState, String>(
                            selector: (_, gameState) =>
                                '${gameState.num1} ${gameState.operation} ${gameState.num2}',
                            builder: (_, equation, __) {
                              return Text(
                                equation,
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(
                            text: gameState.currentAnswer),
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appBarColor,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Answer',
                          hintStyle: TextStyle(fontSize: 22),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.grey[300],
              ),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.0,
                children: [
                  for (int i = 1; i <= 9; i++)
                    DialButton(
                      label: '$i',
                      onTap: () {
                        context.read<GameState>().appendToAnswer(i.toString());
                      },
                    ),
                  DialButton(
                    label: 'CE',
                    onTap: () {
                      context.read<GameState>().clearAnswer();
                    },
                  ),
                  DialButton(
                    label: '0',
                    onTap: () {
                      context.read<GameState>().appendToAnswer('0');
                    },
                  ),
                  DialButton(
                    label: 'Submit',
                    onTap: () {
                      context.read<GameState>().submitAnswer(context);
                    },
                    isSpecial: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
