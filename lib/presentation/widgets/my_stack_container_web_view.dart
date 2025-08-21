import 'package:flutter/material.dart';
import 'package:my_portfolio_app/presentation/widgets/stack_container.dart';

class MyStackContainerWebView extends StatelessWidget {
  const MyStackContainerWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: StackContainer(image: 'android', title: 'Android Development'),
        ),
        Expanded(
          child: StackContainer(image: 'apple', title: 'IOS Development'),
        ),
        Expanded(
          child: StackContainer(image: 'web', title: 'Web App Development'),
        ),
        Expanded(
          child: StackContainer(image: 'desktop', title: 'Desktop Development'),
        ),
      ],
    );
  }
}
