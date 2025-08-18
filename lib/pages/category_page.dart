import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_app/data/show_category.dart';

import 'package:news_app/models/show_category_model.dart';
import 'package:news_app/widgets/trending_widget.dart';

class CategoryPage extends StatefulWidget {
  String selectedCategory;
  CategoryPage(this.selectedCategory);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ShowCategoryModel> categoriess = [];
  bool _loading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    getCategoriesNews();
  }

  getCategoriesNews() async {
    try {
      ShowCategoryData showCategoryData = ShowCategoryData();
      await showCategoryData.getCategoriesNews(
        widget.selectedCategory.toLowerCase(),
      );
      setState(() {
        categoriess = showCategoryData.categories;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load news: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedCategory,
          style: TextStyle(
            fontFamily: 'Libertinus Serif',
            fontWeight: FontWeight.w900,
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: categoriess.length,
          itemBuilder: (context, index) {
            final category = categoriess[index];
            return ShowCategoryWidget(
              image: category.urlToImage ?? '',
              title: category.title ?? '',
              description: category.description ?? '',
              url: category.url ?? '',
            );
          },
        ),
      ),
    );
  }
}

class ShowCategoryWidget extends StatelessWidget {
  final String image, description, title, url;
  const ShowCategoryWidget({
    required this.image,
    required this.description,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlogTile(
                imageUrl: image,
                title: title,
                description: description,
                blogUrl: url,
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
              fontFamily: 'Libertinus Serif',
              
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            description,
            maxLines: 3,
            style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
