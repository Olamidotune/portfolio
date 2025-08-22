import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';
import 'package:my_portfolio_app/presentation/widgets/project_details_modal.dart';
import 'package:url_launcher/url_launcher.dart';

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
            padding: EdgeInsets.zero,
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_buildProjectImage(), _buildProjectContent()],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectImage() {
    return Container(
      height: 200,
      width: double.infinity,
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

  Widget _buildProjectContent() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.horizontalSpacing),
      child: Column(
        children: [
          Text(
            widget.project.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppSpacing.verticalSpaceMedium,
          Text(
            widget.project.description,
            style: TextStyle(fontSize: 14, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          AppSpacing.verticalSpaceMedium,
          // Tech tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                widget.project.techStack
                    .map((tech) => _buildTechTag(tech))
                    .toList(),
          ),
          AppSpacing.verticalSpaceMedium,
          // Action buttons
          Row(
            children: [
              if (widget.project.demoUrl != null)
                _buildActionButton(
                  'Live Demo',
                  'new-tab',
                  () => _launchUrl(widget.project.demoUrl!),
                ),
              AppSpacing.horizontalSpaceSmall,
              _buildActionButton(
                'PlayStore',
                'play_store',
                () => _launchUrl(widget.project.playStoreUrl!),
              ),
              AppSpacing.horizontalSpaceSmall,
              _buildActionButton(
                'App Store',
                'apple',
                () => _launchUrl(widget.project.appStoreUrl!),
              ),
              AppSpacing.horizontalSpaceSmall,
              if (widget.project.demoUrl != null &&
                  widget.project.codeUrl != null)
                const SizedBox(width: 12),
              if (widget.project.codeUrl != null)
                _buildActionButton(
                  'View Code',
                  'new-tab',
                  () => _launchUrl(widget.project.codeUrl!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
      ),
      child: Text(
        tech,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildActionButton(String text, String icon, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset('assets/images/$icon.png', height: 20, width: 20),
        label: Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailsModal(project: widget.project),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}
