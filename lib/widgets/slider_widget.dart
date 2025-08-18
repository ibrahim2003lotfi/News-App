import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/slider_data.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/widgets/buildImage_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  List<SliderModel> sliders = [];
  int activeIndex = 0;

  getSliders() async {
    SliderData slider = SliderData();
    await slider.getSliders();
    setState(() {
      sliders = slider.sliders;
    });
  }

  @override
  void initState() {
    getSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News!',
                style: TextStyle(
                  fontFamily: 'Libertinus Serif',
                  
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider.builder(
          itemCount: sliders.length,
          itemBuilder: (context, index, realIndex) {
            String? res = sliders[index].urlToImage;
            String? res1 = sliders[index].title;
            String? res2 = sliders[index].url;
            return buildImage(res!, index, res1!, res2!);
          },
          options: CarouselOptions(
            height: size.height * .3,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        buildIdenticator(),
      ],
    );
  }

  Widget buildImage(String urlImage, int index, String name, String blogUrl) {
    return BuildimageWidget(urlImage, index, name, blogUrl);
  }

  Widget buildIdenticator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: sliders.length - 2,
    effect: SlideEffect(
      dotWidth: 15,
      dotHeight: 15,
      activeDotColor: Colors.blue,
    ),
  );
}
