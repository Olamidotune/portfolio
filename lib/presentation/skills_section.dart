import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/skills/skill_card.dart';
import 'package:my_portfolio_app/utils/skill_category.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Skills & Expertise',

            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSpaceMedium,
          LayoutBuilder(
            builder: (context, constraints) {
              return SkillsGrid(
                crossAxisCount:
                    constraints.maxWidth > 1200
                        ? 4
                        : constraints.maxWidth > 800
                        ? 2
                        : 1,
              );
            },
          ),
        ],
      ),
    );
  }
}

class SkillsGrid extends StatelessWidget {
  final int crossAxisCount;

  const SkillsGrid({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.0,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: skillCategories.length,
      itemBuilder: (context, index) {
        return SkillCard(skillCategory: skillCategories[index]);
      },
    );
  }
}
