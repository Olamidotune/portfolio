import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final AnimationController controller;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Lottie.asset(
        height: 80,
        'assets/lottie/$icon.json',
        controller: controller,
        repeat: false,
        onLoaded: (composition) {
          controller
            ..duration = composition.duration
            ..repeat();
        },
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
