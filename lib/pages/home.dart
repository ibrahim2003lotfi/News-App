import 'package:flutter/material.dart';

import 'package:news_app/data/data.dart';

import 'package:news_app/models/category_model.dart';
import 'package:news_app/widgets/category_widget.dart';
import 'package:news_app/widgets/slider_widget.dart';
import 'package:news_app/widgets/trending_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _ToprowWidgetState();
}

class _ToprowWidgetState extends State<Home> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(
                    categories[index].categoryImage,
                    categories[index].categoryName,
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            SliderWidget(),
            SizedBox(height: 30),
            TrendingWidget(),
          ],
        ),
      ),
    );
  }
}
