import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/skills/skill_card.dart';
import 'package:my_portfolio_app/utils/skill_category.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Skills & Expertise',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Comprehensive Flutter development skills with focus on performance, architecture, and user experience',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
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
