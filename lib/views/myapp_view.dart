import 'package:dot3_demo/provider/game_provider.dart';
import 'package:dot3_demo/views/game_view.dart';
import 'package:dot3_demo/widgets/appbar_widegt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomAppBar(),
          body: GameScreen(),
        ),
      ),
    );
  }
}
