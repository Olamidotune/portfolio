import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/skills/skill_details_modal.dart';
import 'package:my_portfolio_app/utils/skill_category.dart';

class SkillCard extends StatefulWidget {
  final SkillCategory skillCategory;

  const SkillCard({super.key, required this.skillCategory});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: GestureDetector(
                onTap: () => _showSkillDetails(context),
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.containerPadding),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: .1),
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: widget.skillCategory.primaryColor.withOpacity(0.1),
                    //     blurRadius: 20,
                    //     offset: const Offset(4, 10),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Icon
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 600),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.skillCategory.primaryColor,
                                    widget.skillCategory.secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.skillCategory.primaryColor
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                widget.skillCategory.icon,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Category Title
                      Text(
                        widget.skillCategory.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Skills List
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            widget.skillCategory.skills
                                .take(
                                  4,
                                ) // Show only first 4 skills to prevent overflow
                                .map(
                                  (skill) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color:
                                                widget
                                                    .skillCategory
                                                    .primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            skill.name,
                                            style: TextStyle(),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                      ),

                      // View More Button
                      if (widget.skillCategory.skills.length > 4)
                        TextButton(
                          onPressed: () => _showSkillDetails(context),
                          style: TextButton.styleFrom(
                            foregroundColor: widget.skillCategory.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            '+${widget.skillCategory.skills.length - 4} more',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSkillDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => SkillDetailsModal(skillCategory: widget.skillCategory),
    );
  }
}
