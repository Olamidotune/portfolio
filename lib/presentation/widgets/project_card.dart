import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

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
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildProjectImage(), _buildProjectContent()],
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
      child: Stack(
        children: [
          // Background pattern or image
          Center(
            child: Icon(
              widget.project.icon,
              size: 60,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          // Demo badge
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.project.demoType,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.project.gradientColors.first,
                ),
              ),
            ),
          ),
          // Play button overlay
          if (widget.project.hasDemo)
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project title
          Text(
            widget.project.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 8),

          // Project description
          Text(
            widget.project.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),

          // Tech tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                widget.project.techStack
                    .map((tech) => _buildTechTag(tech))
                    .toList(),
          ),
          const SizedBox(height: 20),

          // Action buttons
          Row(
            children: [
              if (widget.project.demoUrl != null)
                _buildActionButton(
                  'Live Demo',
                  Colors.green,
                  Icons.launch,
                  () => _launchUrl(widget.project.demoUrl!),
                ),
              if (widget.project.demoUrl != null &&
                  widget.project.codeUrl != null)
                const SizedBox(width: 12),
              if (widget.project.codeUrl != null)
                _buildActionButton(
                  'View Code',
                  Colors.grey[300]!,
                  Icons.code,
                  () => _launchUrl(widget.project.codeUrl!),
                  textColor: Colors.black87,
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
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1976D2),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color backgroundColor,
    IconData icon,
    VoidCallback onPressed, {
    Color textColor = Colors.white,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
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

class ProjectDetailsModal extends StatelessWidget {
  final Project project;

  const ProjectDetailsModal({Key? key, required this.project})
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
            // Modal Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: project.gradientColors,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${project.title} - Case Study',
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

            // Modal Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('Project Overview', project.fullDescription),
                    const SizedBox(height: 20),
                    _buildSection('Key Features', project.features),
                    const SizedBox(height: 20),
                    _buildSection(
                      'Technical Implementation',
                      project.technicalDetails,
                    ),
                    if (project.challenges.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildSection(
                        'Challenges & Solutions',
                        project.challenges,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, dynamic content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 12),
        if (content is String)
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          )
        else if (content is List<String>)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                content
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }
}

// Project Grid Widget
class ProjectsGrid extends StatelessWidget {
  final List<Project> projects;

  const ProjectsGrid({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
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

// Project Data Model
class Project {
  final String title;
  final String description;
  final String fullDescription;
  final List<String> techStack;
  final List<Color> gradientColors;
  final IconData icon;
  final String demoType;
  final bool hasDemo;
  final String? demoUrl;
  final String? codeUrl;
  final List<String> features;
  final List<String> technicalDetails;
  final List<String> challenges;

  const Project({
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.techStack,
    required this.gradientColors,
    required this.icon,
    required this.demoType,
    this.hasDemo = true,
    this.demoUrl,
    this.codeUrl,
    this.features = const [],
    this.technicalDetails = const [],
    this.challenges = const [],
  });
}

// Sample Data
List<Project> sampleProjects = [
  Project(
    title: 'E-Commerce App',
    description:
        'A full-featured shopping app with real-time inventory, payment integration, and beautiful animations.',
    fullDescription:
        'A comprehensive e-commerce solution built with Flutter, featuring real-time inventory management, secure payment processing, and an intuitive user experience.',
    techStack: ['Flutter', 'Bloc', 'Firebase', 'Stripe'],
    gradientColors: [Color(0xFF667eea), Color(0xFF764ba2)],
    icon: Icons.shopping_cart,
    demoType: 'Live Demo',
    demoUrl: 'https://your-demo-url.com',
    codeUrl: 'https://github.com/yourusername/ecommerce-app',
    features: [
      'Product catalog with advanced filtering',
      'Shopping cart with real-time updates',
      'Secure payment integration (Stripe)',
      'Order tracking and history',
      'Push notifications',
      'Admin panel for inventory management',
    ],
    technicalDetails: [
      'State Management: Used BLoC pattern for predictable state management',
      'Architecture: Implemented clean architecture with dependency injection',
      'Performance: Optimized list rendering with pagination and caching',
      'Testing: Comprehensive unit and widget tests (90% coverage)',
    ],
    challenges: [
      'Real-time inventory updates: Solved with WebSocket connections and optimistic UI updates',
      'Payment security: Implemented tokenization and PCI compliance measures',
      'Cross-platform consistency: Used platform-specific adaptations while maintaining unified UX',
    ],
  ),
  Project(
    title: 'Fitness Tracker',
    description:
        'Cross-platform fitness app with workout tracking, progress analytics, and social features.',
    fullDescription:
        'A comprehensive fitness tracking app that motivates users through gamification and social features.',
    techStack: ['Flutter', 'Provider', 'SQLite', 'Charts'],
    gradientColors: [Color(0xFF11998e), Color(0xFF38ef7d)],
    icon: Icons.fitness_center,
    demoType: 'Case Study',
    codeUrl: 'https://github.com/yourusername/fitness-tracker',
    features: [
      'Workout tracking with custom exercises',
      'Progress analytics and charts',
      'Social challenges and leaderboards',
      'Nutrition tracking integration',
      'Offline workout capability',
      'Wearable device synchronization',
    ],
    technicalDetails: [
      'Data Persistence: SQLite with Drift ORM for local storage',
      'Animations: Custom implicit and explicit animations',
      'Sensors: Integration with device sensors for step counting',
      'Charts: Custom chart widgets with fl_chart',
    ],
    challenges: [
      'Battery optimization: Implemented intelligent background processing',
      'Data synchronization: Created robust offline-first architecture',
      'User motivation: Designed gamification system with achievement badges',
    ],
  ),
  Project(
    title: 'Weather Dashboard',
    description:
        'Beautiful weather app with location-based forecasts, interactive maps, and custom animations.',
    fullDescription:
        'An open-source weather application showcasing modern Flutter development practices and beautiful UI design.',
    techStack: ['Flutter', 'Riverpod', 'API Integration', 'Maps'],
    gradientColors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
    icon: Icons.wb_sunny,
    demoType: 'Open Source',
    demoUrl: 'https://your-weather-demo.com',
    codeUrl: 'https://github.com/yourusername/weather-dashboard',
    features: [
      'Location-based weather forecasts',
      'Interactive weather maps',
      'Weather alerts and notifications',
      'Multiple location management',
      'Dark/light theme support',
      'Accessibility features',
    ],
    technicalDetails: [
      'State Management: Riverpod for reactive programming',
      'API: OpenWeatherMap API integration',
      'Maps: Google Maps integration',
      'Storage: Shared preferences and Hive',
    ],
    challenges: [
      'API rate limiting: Implemented intelligent caching and request batching',
      'Location accuracy: Used fused location provider for better precision',
      'Accessibility: Ensured screen reader compatibility and high contrast support',
    ],
  ),
];

// Usage Example
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Flutter Portfolio'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Featured Projects',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 40),
            ProjectsGrid(projects: sampleProjects),
          ],
        ),
      ),
    );
  }
}
