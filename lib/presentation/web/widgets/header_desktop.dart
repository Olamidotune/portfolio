import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/services/theme_service.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({super.key, required this.navTitles});

  final List<String> navTitles;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeService.isDarkMode(context);
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: [Colors.transparent, AppColors.primaryColor],
        ),
      ),
      child: Row(
        children: [
          AppSpacing.horizontalSpaceTeenyTiny,
          SiteLogo(onTap: () {}),
          Spacer(),
          for (int i = 0; i < navTitles.length; i++)
            TextButton(
              onPressed: () {},
              child: Text(
                navTitles[i],
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          AppSpacing.horizontalSpaceTeenyTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () {
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

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.person, size: 50),
          Text(
            'Oladotun',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
