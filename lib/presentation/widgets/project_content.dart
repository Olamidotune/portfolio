import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/mobile/widgets/info_mobile.dart';
import 'package:my_portfolio_app/presentation/widgets/action_button.dart';
import 'package:my_portfolio_app/presentation/widgets/project_card.dart';
import 'package:my_portfolio_app/presentation/widgets/tech_tag.dart';

class ProjectContent extends StatelessWidget {
  const ProjectContent({super.key, required this.widget});

  final ProjectCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.alertDialogInsetPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              widget.project.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          AppSpacing.verticalSpaceMedium,
          Flexible(
            child: Text(
              widget.project.description,
              style: TextStyle(fontSize: 14, height: 1.4),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AppSpacing.verticalSpaceMedium,
          Flexible(
            child: TechTag(
              tech: widget.project.techStack.join(', '),
              project: widget.project,
            ),
          ),
          AppSpacing.verticalSpaceMedium,
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.project.demoUrl != null)
                  Expanded(
                    child: ActionButton(
                      // text: 'Live Demo',
                      icon: 'new-tab',
                      onPressed:
                          () => launchResumeLink(widget.project.demoUrl!),
                    ),
                  ),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: ActionButton(
                    // text: 'PlayStore',
                    icon: 'play_store',
                    onPressed:
                        () => launchResumeLink(widget.project.playStoreUrl!),
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: ActionButton(
                    // text: 'App Store',
                    icon: 'apple',
                    onPressed:
                        () => launchResumeLink(widget.project.appStoreUrl!),
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                if (widget.project.codeUrl != null)
                  Expanded(
                    child: ActionButton(
                      icon: 'github',
                      onPressed:
                          () => launchResumeLink(widget.project.codeUrl!),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
