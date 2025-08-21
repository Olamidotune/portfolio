import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/stack_container.dart';

class MyStackContainerMobileView extends StatelessWidget {
  const MyStackContainerMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        Row(
          spacing: 30,
          children: [
            Expanded(
              child: StackContainer(
                image: 'android',
                title: 'Android Development',
              ),
            ),
            Expanded(
              child: StackContainer(image: 'apple', title: 'IOS Development'),
            ),
          ],
        ),
        Row(
          spacing: 30,
          children: [
            Expanded(
              child: StackContainer(image: 'web', title: 'Web App Development'),
            ),
            Expanded(
              child: StackContainer(
                image: 'desktop',
                title: 'Desktop Development',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
