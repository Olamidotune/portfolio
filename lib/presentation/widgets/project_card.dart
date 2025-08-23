import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';
import 'package:my_portfolio_app/presentation/widgets/project_content.dart';
import 'package:my_portfolio_app/presentation/widgets/project_details_modal.dart';
import 'package:my_portfolio_app/presentation/widgets/project_image.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 8.0, end: 20.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.alertDialogInsetPadding),
            child: MouseRegion(
              onEnter: (_) => _animationController.forward(),
              onExit: (_) => _animationController.reverse(),
              child: GestureDetector(
                onTap: () => _showProjectDetails(context),
                child: Card(
                  elevation: _elevationAnimation.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(flex: 6, child: ProjectImage(widget: widget)),
                      Expanded(flex: 10, child: ProjectContent(widget: widget)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showProjectDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailsModal(project: widget.project),
    );
  }
}
