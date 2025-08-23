import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/project_card.dart';

class ProjectImage extends StatelessWidget {
  const ProjectImage({super.key, required this.widget});

  final ProjectCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.project.gradientColors,
        ),
      ),
      child: Center(child: widget.project.icon),
    );
  }
}
