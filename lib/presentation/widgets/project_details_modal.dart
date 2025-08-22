import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';

class ProjectDetailsModal extends StatelessWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (content is String)
          Text(content, style: TextStyle(fontSize: 14, height: 1.5))
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
                                style: TextStyle(fontSize: 14, height: 1.4),
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
