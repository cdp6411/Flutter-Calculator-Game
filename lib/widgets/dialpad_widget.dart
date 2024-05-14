import 'package:dot3_demo/constant/app_colors.dart';
import 'package:flutter/material.dart';

class DialButton extends StatelessWidget {
  final String label;
  final bool isSpecial;
  final VoidCallback onTap;

  const DialButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: isSpecial
            ? const Icon(
                Icons.send,
                color: AppColors.appBarColor,
                size: 24,
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appBarColor,
                ),
              ),
      ),
    );
  }
}
