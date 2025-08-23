// Project Grid Widget
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';
import 'package:my_portfolio_app/presentation/widgets/project_card.dart';

class ProjectsGrid extends StatelessWidget {
  final List<Project> projects;

  const ProjectsGrid({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * .7,
      child: PageView.builder(
        itemCount: projects.length,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}
