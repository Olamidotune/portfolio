import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  const ActionButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        child: Image.asset('assets/images/$icon.png', height: 24, width: 24),
      ),
    );
  }
}
