// Project Grid Widget
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';
import 'package:my_portfolio_app/presentation/widgets/project_card.dart';

class ProjectsGrid extends StatelessWidget {
  final List<Project> projects;

  const ProjectsGrid({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: projects.length,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 50,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index]);
          },
        );
      },
    );
  }
}
