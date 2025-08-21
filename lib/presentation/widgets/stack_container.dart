import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';

class StackContainer extends StatelessWidget {
  final String image;
  final String title;
  const StackContainer({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      padding: EdgeInsets.all(AppSpacing.horizontalSpacing),
      child: Row(
        spacing: 30,
        children: [
          Image.asset('assets/images/$image.png', height: 50, width: 50),
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
