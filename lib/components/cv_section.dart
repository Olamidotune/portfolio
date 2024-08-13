import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/cv_model.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/screen_helper.dart';

final List<CvModel> cvModel = [
  CvModel(
    title: "DESIGN",
    imagePath: "assets/design.png",
    subtitle:
        "A full stack allround designer thay may or may not include a guide for specific creative",
  ),
  CvModel(
    title: "DEVELOP",
    imagePath: "assets/develop.png",
    subtitle:
        "A full stack allround developer thay may or may not include a guide for specific creative",
  ),
  CvModel(
    title: "WRITE",
    imagePath: "assets/write.png",
    subtitle:
        "A full stack allround writer thay may or may not include a guide for specific creative",
  ),
  CvModel(
    title: "PROMOTE",
    imagePath: "assets/promote.png",
    subtitle:
        "A full stack allround promoter thay may or may not include a guide for specific creative",
  ),
];

class CvSection extends StatelessWidget {
  const CvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ScreenHelper(
        mobile: _buildUi(context, getMobileMaxWidth(context)),
        tablet: _buildUi(context, kTabletMaxWidth),
        desktop: _buildUi(context, kDesktopMaxWidth),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    return Center(
      child: Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Better Design, Better Experiences",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.8,
                    fontSize: 18.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "DOWNLOAD CV",
                      style: GoogleFonts.oswald(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double itemWidth;
                  double aspectRatio;
                  if (ScreenHelper.isMobile(context) ||
                      ScreenHelper.isTablet(context)) {
                    itemWidth = constraints.maxWidth / 2.0;
                    aspectRatio = MediaQuery.of(context).size.aspectRatio * 1.5;
                  } else {
                    itemWidth = 250;
                    aspectRatio = 1;
                  }
                  return GridView.builder(
                    itemCount: cvModel.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: itemWidth,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: aspectRatio,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  cvModel[index].imagePath,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  cvModel[index].title,
                                  style: GoogleFonts.oswald(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              cvModel[index].subtitle,
                              style: TextStyle(
                                color: kCaptionColor,
                                height: 1.5,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
