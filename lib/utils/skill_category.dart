// Data Models
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/skills_section.dart';

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
        'Comprehensive mobile app development with Flutter, focusing on cross-platform solutions and optimal user experiences across iOS and Android platforms.',
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
      const Skill(name: 'Code Review', proficiency: 0.68),
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
