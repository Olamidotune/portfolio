import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/components/carouselItems.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/screen_helper.dart';

class Carousel extends StatelessWidget {
  Carousel({super.key});

  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    double carouselContainerHeight = MediaQuery.of(context).size.height *
        (ScreenHelper.isMobile(context) ? .8 : .85);
    return Container(
      height: carouselContainerHeight,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                viewportFraction: 1,
                scrollPhysics: NeverScrollableScrollPhysics(),
                height: carouselContainerHeight,
              ),
              items: List.generate(
                carouselItems.length,
                (index) => Builder(
                  builder: (BuildContext context) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: carouselContainerHeight,
                      ),
                      child: ScreenHelper(
                        // Responsive views
                        desktop: _buildDesktop(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                        tablet: _buildTablet(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                        mobile: _buildMobile(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                      ),
                    );
                  },
                ),
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

//Big Screens
Widget _buildDesktop(BuildContext context, Widget text, Widget image) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth < kDesktopMaxWidth
            ? constraints.maxWidth
            : kDesktopMaxWidth;

        return Container(
          width: maxWidth,
          child: Row(
            children: [
              Expanded(
                child: text,
              ),
              Expanded(
                child: image,
              ),
            ],
          ),
        );
      },
    ),
  );
}

//Tablet Screens
Widget _buildTablet(BuildContext context, Widget text, Widget image) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth < kTabletMaxWidth
            ? constraints.maxWidth
            : kTabletMaxWidth;

        return Container(
          width: maxWidth,
          child: Row(
            children: [
              Expanded(
                child: text,
              ),
              Expanded(
                child: image,
              ),
            ],
          ),
        );
      },
    ),
  );
}

// SMall Screens
Widget _buildMobile(BuildContext context, Widget text, Widget image) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: getMobileMaxWidth(context),
    ),
    width: double.infinity,
    child: text,
  );
}
