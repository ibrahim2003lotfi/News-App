import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/show_category_model.dart';
import 'package:news_app/models/slider_model.dart';

class ShowCategoryData {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String categoryName) async {
    try {
      final apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
      final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$categoryName&apiKey=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          categories = (jsonData['articles'] as List)
              .where(
                (element) =>
                    element['urlToImage'] != null &&
                    element['description'] != null,
              )
              .map(
                (category) => ShowCategoryModel(
                  title: category['title'],
                  description: category['description'],
                  url: category['url'],
                  urlToImage: category['urlToImage'],
                  content: category['content'],
                  author: category['author'],
                ),
              )
              .cast<ShowCategoryModel>()
              .toList();
        }
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}

