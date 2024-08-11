import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/header_item.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/globals.dart';
import 'package:portfolio/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

List<HeaderItem> headerItems = [
  HeaderItem(
    title: "HOME",
    onTap: () {},
    isButton: true,
  ),
  HeaderItem(title: "MY INTRO", onTap: () {}, isButton: true),
  HeaderItem(title: "SERVICES", onTap: () {}, isButton: true),
  HeaderItem(title: "PORTFOLIO", onTap: () {}, isButton: true),
  HeaderItem(title: "TESTIMONIALS", onTap: () {}, isButton: true),
  HeaderItem(title: "BLOGS", onTap: () {}, isButton: true),
  HeaderItem(
    title: "HIRE ME",
    onTap: () {},
    isButton: true,
  ),
];

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
          mobile: buildMobileHeader(),
          tablet: buildTabletHeader(),
          desktop: buildDesktopHeader()),
    );
  }

  Widget buildMobileHeader() {
    return SafeArea(
      child: Row(
        children: [
          HeaderLogo(),
          GestureDetector(
            onTap: () {
              Globals.scaffoldKey.currentState!.openEndDrawer();
            },
          )
        ],
      ),
    );
  }

  Widget buildTabletHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderLogo(),
          HeaderRow(),
        ],
      ),
    );
  }

  Widget buildDesktopHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderLogo(),
          HeaderRow(),
        ],
      ),
    );
  }
}

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "EO",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ".",
                  style: GoogleFonts.oswald(
                    color: kPrimaryColor,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleConditions: [
        Condition.largerThan(name: MOBILE),
      ],
      child: Row(
          children: headerItems
              .map(
                (e) => e.isButton
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDangerColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: TextButton(
                            onPressed: e.onTap,
                            child: Text(
                              e.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          margin: EdgeInsets.only(right: 30.0),
                          child: GestureDetector(
                            onTap: e.onTap,
                            child: Text(
                              e.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
              )
              .toList()),
    );
  }
}
