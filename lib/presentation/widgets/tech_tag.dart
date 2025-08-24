import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';

class TechTag extends StatelessWidget {
  final String tech;
  final Project project;
  const TechTag({super.key, required this.tech, required this.project});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          project.techStack
              .map(
                (tech) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor,
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
    );
  }
}
