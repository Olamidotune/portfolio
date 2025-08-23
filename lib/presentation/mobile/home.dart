import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/constants/app_spacing.dart';
import 'package:my_portfolio_app/presentation/contact_section.dart';
import 'package:my_portfolio_app/presentation/demo.dart';
import 'package:my_portfolio_app/presentation/mobile/widgets/header_mobile.dart';
import 'package:my_portfolio_app/presentation/mobile/widgets/info_mobile.dart';
import 'package:my_portfolio_app/presentation/mobile/widgets/my_drawer.dart';
import 'package:my_portfolio_app/presentation/skills_section.dart';
import 'package:my_portfolio_app/presentation/web/widgets/info_desktop.dart';
import 'package:my_portfolio_app/presentation/web/widgets/header_desktop.dart';

class PortfolioHome extends HookWidget {
  const PortfolioHome({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final cursorPosition = useState(const Offset(0, 0));
    final controller = useAnimationController();
    final scrollController = useScrollController();
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>(), []);

    List<String> navTitles = ['Home', 'Skills', 'Resume', 'Project', 'Contact'];

    return Stack(
      children: [
        MouseRegion(
          onHover: (event) => cursorPosition.value = event.position,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Scaffold(
                key: scaffoldKey,
                endDrawer: MyDrawer(controller: controller),
                body: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.horizontalSpacing),
                    child: Column(
                      children: [
                        constraints.maxWidth > 676
                            ? HeaderDesktop(navTitles: navTitles)
                            : HeaderMobile(
                              onLogoTap: () {},
                              onMenuTap: () {
                                scaffoldKey.currentState?.openEndDrawer();
                              },
                            ),
                        AppSpacing.verticalSpaceMedium,
                        constraints.maxWidth > 885
                            ? InfoDesktop(controller: controller)
                            : InfoMobile(controller: controller),
                        AppSpacing.verticalSpaceLarge,
                        Text(
                          'Projects I have built over the years\nas a Flutter Developer',
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.verticalSpaceMedium,
                        SizedBox(
                          height: 500,
                          child: CustomScrollBehaviorDemo(
                            constraints: constraints,
                          ),
                        ),
                        AppSpacing.verticalSpaceLarge,
                        const SkillsSection(),
                        AppSpacing.verticalSpaceLarge,
                        const ContactSection(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: cursorPosition.value.dx - 250.0,
          top: cursorPosition.value.dy - 250.0,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: .001),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        ThemeMode.system == ThemeMode.dark
                            ? AppColors.greyColor.withValues(alpha: .2)
                            : AppColors.primaryColor.withValues(alpha: .1),
                    blurRadius: 160,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
