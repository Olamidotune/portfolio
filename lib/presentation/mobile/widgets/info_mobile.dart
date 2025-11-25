import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/web/widgets/info_desktop.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoMobile extends StatelessWidget {
  const InfoMobile({super.key, required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AnimatedIntroText(),
        AppSpacing.verticalSpaceMedium,
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Lottie.asset(
              height: 400,
              'assets/lottie/coding_boy.json',
              controller: controller,
              repeat: false,
              onLoaded: (composition) {
                controller
                  ..duration = composition.duration
                  ..repeat();
              },
            ),
          ),
        ),
        AppSpacing.verticalSpaceMedium,
        Text(
          "Detail-oriented and technically proficient Flutter developer with a strong foundation in building and  maintaining cross-platform mobile applications. Experienced in developing clean, scalable codebases using Bloc architecture and Freezed for robust state management. Demonstrates a solid grasp of API integration, data handling, and user role-based system design, with a focus on performance, reliability, and maintainability. Committed to continuous learning and delivering high-quality software solutions that align with business goals.",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        AppSpacing.verticalSpaceMedium,
        ElevatedButton(
          onPressed: () {
            launchResumeLink('https://flowcv.com/resume/5k7tubs0be');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              const Icon(Icons.newspaper),
              const Text("View My Resume"),
            ],
          ),
        ),
      ],
    );
  }
}

void launchResumeLink(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
