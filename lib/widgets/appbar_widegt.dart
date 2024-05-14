import 'package:dot3_demo/constant/app_colors.dart';
import 'package:dot3_demo/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, _) {
        return AppBar(
          backgroundColor: AppColors.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(3, (index) {
                  return Icon(
                    Icons.favorite,
                    color: index < gameState.lives
                        ? AppColors.iconColor
                        : Colors.white,
                  );
                }),
              ),
              Text(
                'Points: ${gameState.points}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
