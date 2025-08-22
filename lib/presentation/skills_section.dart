import 'package:flutter/material.dart';

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

  const SkillsGrid({Key? key, required this.crossAxisCount}) : super(key: key);

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

class SkillCard extends StatefulWidget {
  final SkillCategory skillCategory;

  const SkillCard({Key? key, required this.skillCategory}) : super(key: key);

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
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.skillCategory.primaryColor.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Skills List
                    Expanded(
                      child: Column(
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
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
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

class SkillDetailsModal extends StatelessWidget {
  final SkillCategory skillCategory;

  const SkillDetailsModal({Key? key, required this.skillCategory})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // maxWidth: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    skillCategory.primaryColor,
                    skillCategory.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Icon(skillCategory.icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      skillCategory.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skillCategory.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Skills & Technologies',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Skills with proficiency bars
                    ...skillCategory.skills.map(
                      (skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SkillProficiencyBar(
                          skill: skill,
                          color: skillCategory.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillProficiencyBar extends StatelessWidget {
  final Skill skill;
  final Color color;

  const SkillProficiencyBar({
    Key? key,
    required this.skill,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            Text(
              '${(skill.proficiency * 100).toInt()}%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          duration: Duration(
            milliseconds: 1000 + (skill.proficiency * 500).toInt(),
          ),
          tween: Tween(begin: 0.0, end: skill.proficiency),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Container(
              width: double.infinity,
              height: 6,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                widthFactor: value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Data Models
class SkillCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final List<Skill> skills;

  const SkillCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.skills,
  });
}

class Skill {
  final String name;
  final double proficiency; // 0.0 to 1.0

  const Skill({required this.name, required this.proficiency});
}

// Sample Data
final List<SkillCategory> skillCategories = [
  SkillCategory(
    title: 'Mobile Development',
    description:
        'Comprehensive mobile app development with Flutter, focusing on cross-platform solutions, native integrations, and optimal user experiences across iOS and Android platforms.',
    icon: Icons.phone_android,
    primaryColor: const Color(0xFF2196F3),
    secondaryColor: const Color(0xFF21CBF3),
    skills: [
      const Skill(name: 'Flutter & Dart', proficiency: 0.95),
      const Skill(name: 'Cross-platform Development', proficiency: 0.90),
      const Skill(name: 'Native Android/iOS Integration', proficiency: 0.85),
      const Skill(name: 'App Store Deployment', proficiency: 0.88),
      const Skill(name: 'Platform Channels', proficiency: 0.80),
      const Skill(name: 'Device Integration (Camera, GPS)', proficiency: 0.85),
      const Skill(name: 'Push Notifications', proficiency: 0.85),
      const Skill(name: 'App Performance Optimization', proficiency: 0.82),
    ],
  ),

  SkillCategory(
    title: 'State Management',
    description:
        'Expert knowledge in various state management solutions for Flutter applications, ensuring scalable, maintainable, and performant app architectures.',
    icon: Icons.settings_applications,
    primaryColor: const Color(0xFF4CAF50),
    secondaryColor: const Color(0xFF8BC34A),
    skills: [
      const Skill(name: 'BLoC Pattern', proficiency: 0.92),
      const Skill(name: 'Provider', proficiency: 0.90),
      const Skill(name: 'Riverpod', proficiency: 0.88),
      const Skill(name: 'GetX', proficiency: 0.75),
      const Skill(name: 'Redux', proficiency: 0.70),
      const Skill(name: 'MobX', proficiency: 0.65),
      const Skill(name: 'Cubit', proficiency: 0.85),
    ],
  ),

  SkillCategory(
    title: 'UI/UX & Design',
    description:
        'Creating beautiful, responsive, and accessible user interfaces with custom animations, material design principles, and platform-specific adaptations.',
    icon: Icons.palette,
    primaryColor: const Color(0xFFFF9800),
    secondaryColor: const Color(0xFFFFB74D),
    skills: [
      const Skill(name: 'Material Design', proficiency: 0.93),
      const Skill(name: 'Cupertino Design', proficiency: 0.88),
      const Skill(name: 'Custom Widgets', proficiency: 0.90),
      const Skill(name: 'Animations & Transitions', proficiency: 0.87),
      const Skill(name: 'Responsive Design', proficiency: 0.85),
      const Skill(name: 'Accessibility (a11y)', proficiency: 0.80),
      const Skill(name: 'Custom Paint & Canvas', proficiency: 0.75),
      const Skill(name: 'Theme Management', proficiency: 0.90),
    ],
  ),

  SkillCategory(
    title: 'Backend & Integration',
    description:
        'Full-stack development capabilities including API integration, database management, cloud services, and backend-as-a-service solutions.',
    icon: Icons.cloud,
    primaryColor: const Color(0xFF9C27B0),
    secondaryColor: const Color(0xFFBA68C8),
    skills: [
      const Skill(name: 'Firebase', proficiency: 0.90),
      const Skill(name: 'REST APIs', proficiency: 0.92),
      const Skill(name: 'GraphQL', proficiency: 0.75),
      const Skill(name: 'SQLite', proficiency: 0.88),
      const Skill(name: 'Supabase', proficiency: 0.80),
      const Skill(name: 'AWS Services', proficiency: 0.70),
      const Skill(name: 'Real-time Data', proficiency: 0.85),
      const Skill(name: 'Authentication', proficiency: 0.88),
    ],
  ),

  SkillCategory(
    title: 'Testing & Quality',
    description:
        'Comprehensive testing strategies including unit tests, widget tests, integration tests, and automated testing pipelines for reliable app delivery.',
    icon: Icons.bug_report,
    primaryColor: const Color(0xFFE91E63),
    secondaryColor: const Color(0xFFF06292),
    skills: [
      const Skill(name: 'Unit Testing', proficiency: 0.85),
      const Skill(name: 'Widget Testing', proficiency: 0.82),
      const Skill(name: 'Integration Testing', proficiency: 0.78),
      const Skill(name: 'Test-Driven Development', proficiency: 0.75),
      const Skill(name: 'Mockito', proficiency: 0.80),
      const Skill(name: 'Code Coverage', proficiency: 0.83),
      const Skill(name: 'CI/CD Pipelines', proficiency: 0.75),
    ],
  ),

  SkillCategory(
    title: 'DevOps & Tools',
    description:
        'Modern development workflows, version control, continuous integration, deployment strategies, and development tools for efficient project delivery.',
    icon: Icons.build,
    primaryColor: const Color(0xFF607D8B),
    secondaryColor: const Color(0xFF90A4AE),
    skills: [
      const Skill(name: 'Git & GitHub', proficiency: 0.90),
      const Skill(name: 'VS Code', proficiency: 0.95),
      const Skill(name: 'Android Studio', proficiency: 0.85),
      const Skill(name: 'GitHub Actions', proficiency: 0.80),
      const Skill(name: 'Fastlane', proficiency: 0.75),
      const Skill(name: 'App Distribution', proficiency: 0.85),
      const Skill(name: 'Code Review', proficiency: 0.88),
    ],
  ),
];

// Usage Example
class PortfolioSkillsPage extends StatelessWidget {
  const PortfolioSkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'Technical Expertise',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '6+ years of Flutter development experience',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SkillsSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
