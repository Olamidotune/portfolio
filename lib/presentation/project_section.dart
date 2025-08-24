// ignore_for_file: unrelated_type_equality_checks

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/project.dart';
import 'package:my_portfolio_app/presentation/widgets/project_card.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (details.direction == Axis.horizontal) {
      return MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: super.buildScrollbar(context, child, details),
      );
    }
    return super.buildScrollbar(context, child, details);
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class ProjectSection extends HookWidget {
  final BoxConstraints constraints;
  const ProjectSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    final pageController = usePageController();

    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: _buildResponsiveLayout(context, currentIndex, pageController),
      ),
    );
  }

  Widget _buildResponsiveLayout(
    BuildContext context,
    ValueNotifier<int> currentIndex,
    PageController pageController,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 654) {
      return _buildMobileLayout(
        screenWidth,
        screenHeight,
        currentIndex,
        pageController,
      );
    } else {
      return _buildDesktopLayout(screenWidth, currentIndex);
    }
  }

  Widget _buildMobileLayout(
    double screenWidth,
    double screenHeight,
    ValueNotifier<int> currentIndex,
    PageController pageController,
  ) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.43,
          child: _buildPageView(currentIndex, pageController),
        ),
        AppSpacing.verticalSpaceTiny,
        _buildDots(currentIndex.value),
      ],
    );
  }

  Widget _buildDesktopLayout(
    double screenWidth,
    ValueNotifier<int> currentIndex,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CarouselSlider.builder(
            itemCount: sampleProjects.length,
            options: CarouselOptions(
              padEnds: true,
              enlargeCenterPage: true,
              initialPage: 0,
              autoPlay: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
              height: 2000,
              onPageChanged:
                  (newIndex, reason) => currentIndex.value = newIndex,
            ),
            itemBuilder:
                (context, index, realIndex) => _buildProjectCard(index),
          ),
        ),
        _buildDots(currentIndex.value),
      ],
    );
  }

  Widget _buildPageView(
    ValueNotifier<int> currentIndex,
    PageController pageController,
  ) {
    return PageView.builder(
      controller: pageController,
      itemCount: sampleProjects.length,
      onPageChanged: (index) => currentIndex.value = index,
      itemBuilder: (context, index) => _buildProjectCard(index),
    );
  }

  Widget _buildProjectCard(int index) {
    return ProjectCard(project: sampleProjects[index]);
  }

  Widget _buildDots(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        sampleProjects.length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == i ? 20 : 8,
          decoration: BoxDecoration(
            color:
                currentIndex == i
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
