import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/widgets/drawer_item.dart';
import 'package:my_portfolio_app/services/theme_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.isDarkMode(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerItem(
            icon: 'home',
            title: "Home",
            onTap: () {},
            controller: controller,
          ),
          AppSpacing.verticalSpaceSmall,
          DrawerItem(
            icon: 'dev_yoga',
            title: "About",
            onTap: () {},
            controller: controller,
          ),
          AppSpacing.verticalSpaceSmall,
          DrawerItem(
            icon: 'skills',
            title: "Skills",
            onTap: () {},
            controller: controller,
          ),
          AppSpacing.verticalSpaceSmall,
          DrawerItem(
            icon: 'resume',
            title: "Resume",
            onTap: () {},
            controller: controller,
          ),
          AppSpacing.verticalSpaceSmall,
          DrawerItem(
            icon: 'projects',
            title: "Projects",
            onTap: () {},
            controller: controller,
          ),
          AppSpacing.verticalSpaceSmall,
          DrawerItem(
            icon: 'contact',
            title: "Contact",
            onTap: () {},
            controller: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.light_mode),
                  AppSpacing.horizontalSpaceSmall,
                  Text("Dark Modes"),
                ],
              ),
              Switch(
                value: isDark,
                onChanged: (value) {
                  ThemeService.toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// void toggleTheme() {
//   themeModeNotifier.value =
//       themeModeNotifier.value == ThemeMode.dark
//           ? ThemeMode.light
//           : ThemeMode.dark;
// }
