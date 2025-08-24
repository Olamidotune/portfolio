import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/mobile/widgets/info_mobile.dart';

class InfoDesktop extends StatelessWidget {
  const InfoDesktop({super.key, required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(32),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AnimatedIntroText(),
                  AppSpacing.verticalSpaceMedium,
                  Text(
                    "Detail-oriented and technically proficient Flutter developer with a strong foundation in building and  maintaining cross-platform mobile applications. Experienced in developing clean, scalable codebases using Bloc architecture and Freezed for robust state management. Demonstrates a solid grasp of API integration, data handling, and user role-based system design, with a focus on performance, reliability, and maintainability. Committed to continuous learning and delivering high-quality software solutions that align with business goals.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  AppSpacing.verticalSpaceMedium,
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        launchResumeLink(
                          'https://flowcv.com/resume/5k7tubs0be',
                        );
                      },
                      child: Row(
                        spacing: 10,
                        children: [
                          Text(
                            'Launch Resume',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.primaryColor),
                          ),
                          Icon(
                            Icons.arrow_outward_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceMedium,
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}

class AnimatedIntroText extends StatelessWidget {
  const AnimatedIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("👋 Hi, I'm ", style: Theme.of(context).textTheme.displayLarge),
        SizedBox(
          width:
              MediaQuery.of(context).size.width > 600
                  ? 400
                  : MediaQuery.of(context).size.width * 0.8,
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
            animatedTexts: [
              TyperAnimatedText(
                "Egundeyi Oladotun.",
                textStyle: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
                speed: const Duration(milliseconds: 100),
              ),
              TyperAnimatedText(
                "A Flutter Developer.",
                textStyle: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
                speed: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
